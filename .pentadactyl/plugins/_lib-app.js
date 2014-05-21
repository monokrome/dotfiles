//AUTHOR:  Maksim Ryzhikov
//NAME:    _libly-app
//VERSION: 0.4 (monkey)
//HELPERS LIB API {{{
var App = {
	Cc: Components.classes,
	Ci: Components.interfaces,
	pms: function(){ // Permission manager service
		return this.Cc["@mozilla.org/permissionmanager;1"].getService(this.Ci.nsIPermissionManager);
	},
	clip: function(){
		return this.Cc["@mozilla.org/widget/clipboardhelper;1"].getService(this.Ci.nsIClipboardHelper);
	},
	sl: function () { // Stream Loader
		return this.Cc["@mozilla.org/network/stream-loader;1"].createInstance(this.Ci.nsIStreamLoader);
	},
	ios: function () { //io-service
		return this.Cc["@mozilla.org/network/io-service;1"].getService(this.Ci.nsIIOService);
	},
	fstream: function () { //file-input-stream
		return this.Cc["@mozilla.org/network/file-input-stream;1"].createInstance(this.Ci.nsIFileInputStream);
	},
	fostream: function () { //file-output-stream
		return this.Cc["@mozilla.org/network/file-output-stream;1"].createInstance(this.Ci.nsIFileOutputStream);
	},
	cstream: function () { //convert-input-stream
		return this.Cc["@mozilla.org/intl/converter-input-stream;1"].createInstance(this.Ci.nsIConverterInputStream);
	},
	costream: function () { //convert-output-stream
		return this.Cc["@mozilla.org/intl/converter-output-stream;1"].createInstance(this.Ci.nsIConverterOutputStream);
	},
	buffer: function () { //buffer-output
		return this.Cc["@mozilla.org/network/buffered-output-stream;1"].createInstance(this.Ci.nsIBufferedOutputStream);
	},
	/*
	 * ================
	 */
	console: {
		log: function () {
			return window.Firebug.Console.logFormatted.call(window.Firebug.Console, arguments);
		}
	},
	/*
	 *STRING METHODS
	 */
	fromJson: function (json) {
		var inline = "",
		clnwl = json.split('\n');
		for (var i = 0; i < clnwl.length; i++) {
			inline = inline + clnwl[i];
		}
		//FIXME
		var obj = JSON.parse(inline.replace(/,(?!\w+|\"|\{|\[|\s+)/g, '$&\"\"'));
		return obj;
	},
	multi: function (str, num, callback) {
		for (var i = 0, nstr = ""; i < num; i++) {
			nstr += (callback) ? callback(str, i, num, nstr) : str;
		}
		return nstr;
	},
	capitalize: function (str) {
		return str.replace(/(^|\s)([a-z])/g, function (m, p1, p2) {
			return p1 + p2.toUpperCase();
		});
	},
	/*
	 *END (STRING METHODS)
	 */
	hitch: function (scope, callback) {
		if (typeof callback === "string") {
			scope = scope || window;
			return function () {
				return scope[callback].apply(scope, arguments || []);
			}; // Function
		}
		return function () {
			return callback.apply(scope, arguments || []);
		};
	},
	//CONNECT
	connect: function (source, meth, obj, callback) {
		//protected methods
		function _getDispatcher() {
			return function () {
				var a = Array.prototype,
				c = arguments.callee,
				ls = c._listeners,
				t = c.target;
				var result = t && t.apply(this, arguments);
				a.push.call(arguments, result); //add in arguments result root function
				var lls = [].concat(ls);
				for (var i in lls) {
					if (! (i in a)) {
						lls[i].apply(this, arguments);
					}
				}
				return result;
			};
		}
		function _listener(source, meth, listener) {
			var f = source[meth];
			if (!f || !f._listeners) {
				var d = _getDispatcher();
				d.target = f;
				d._listeners = [];
				f = source[meth] = d;
			}
			return f._listeners.push(listener);
		}
		//end protected methods
		var l = _listener,
		h = l(source, meth, this.hitch(obj, callback));
		return [source, meth, h, l]; //Handle
	},
	disconnect: function (handle) {
		//protected methods
		function _disconnect(source, method, handle, listener) {
			var f = (source || window)[method];
			if (f && f._listeners && handle--) {
				delete f._listeners[handle];
			}
		}
		//end protected methods
		if (handle && handle[0] !== undefined) {
			_disconnect.apply(this, handle);
			delete handle[0];
		}
	},
	//END (CONNECT)
	//METHODS CHECKING
	isArray: function (it) {
		return it && (it instanceof Array || typeof it == "array");
	},
	isFunction: function (it) {
		var opts = Object.prototype.toString;
		return opts.call(it) === "[object Function]";
	},
	isObject: function (it) {
		return it !== undefined && (it === null || typeof it == "object" || this.isArray(it) || this.isFunction(it)); // Boolean
	},
	//END
	//METHODS FOR OBJECT AND FUNCTIONS
	_inherited: function (Child, Root) {
		function _Tmp() {}
		_Tmp.prototype = (this.isFunction(Root)) ? Root.prototype: Root;
		_Tmp.prototype.constructor = Child;
		Child.prototype = new _Tmp();
		return Child;
	},
	mixin: function (obj1, obj2) {
		for (var i in obj2) {
			if (obj2.hasOwnProperty(i)) {
				obj1[i] = obj2[i];
			}
		}
		return obj1;
	},
	extend: function (constructor, props) {
		this.mixin(constructor.prototype, props);
		return constructor;
	},
	//END
	attr: function (node, atr, value) {
		return node.setAttribute(atr, value);
	},
	forEach: function (arr, callback, thisObject) {
		if (!arr) {
			return;
		}
		for (var i in arr) {
			if (arr.hasOwnProperty(i)) {
				var args = (arr.constructor == Array) ? [arr[i], i, arr] : [i, arr[i], arr];
				callback.apply(thisObject || this, args);
			}
		}
	},
	hasNode: function (node, root) {
		var nodes = this.query(node.tagName, root);
		return Boolean(this.filter(nodes, function (n) {
			return n === node;
		},
		this).toString());
	},
	filter: function (arr, callback, thisObject) {
		return Array.filter(arr, function () {
			return callback.apply(thisObject || window, arguments);
		});
	},
	byId: function (id, doc) {
		if (typeof id == "string") {
			return (doc || document).getElementById(id); // DomNode
		} else {
			return id; // DomNode
		}
	},
	query: function (str, doc) {
		//TODO:
		//Get nested node:
		//document.getElementById('main').getElementsByClassName('test');
		//Check on prent node have some class how node:
		//Array.filter( test, function(elem){ return Array.indexOf( test, elem.parentNode ) > -1; });
		//result regex: [String,Node,(ClassName|IdName),Identificator("."|"#")]
		var regex = /([\w]*)((#|.)[\S]+)?/ig;
		var cArray = regex.exec(str);
		if (cArray && !cArray[3]) {
			//we have only node
			return (doc || document).getElementsByTagName(cArray[1]);
		}
		else if (cArray) {
			//we class or id
			var name = cArray[2].slice(1);
			var nodes = (cArray[3] == "#") ? [this.byId(name, doc)] : (doc || document).getElementsByClassName(name);
			return (cArray[1]) ? Array.filter(nodes, function (elem) {
				return elem.nodeName == cArray[1].toUpperCase;
			}) : nodes;
		}
	},
	create: function (nodeName, opts, parentNode, pos) {
		var builder = (opts.builder) ? opts.builder: document;
		var node = (nodeName == "textNode") ? builder.createTextNode(opts) : builder.createElement(nodeName);
		if (opts && (typeof opts == "object")) {
			this.forEach(opts, function (key, value) {
				if (key != "builder") {
					node.setAttribute(key, value);
				}
			},
			this);
		}
		if (parentNode && parentNode.nodeType) {
			var _ins = (pos) ? parentNode.insertBefore(node, parentNode.firstChild) : parentNode.appendChild(node);
		}
		return node;
	},
	remove: function (node, parentNode) {
		return (parentNode || document).removeChild(node);
	},
	place: function (node, parentNode) {
		return (parentNode || document).appendChild(node);
	},
	//AJAX METHODS {{{
	xhrGet: function (args) {
		var xhr = new XMLHttpRequest();
		var _defaultContentType = "application/x-www-form-urlencoded";
		xhr.open("GET", args.url, true, args.username || null, args.password || null);
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					return args.load(xhr.responseText || xhr.responseXML);
				} else {
					return null;
				}
			}
		};
		xhr.setRequestHeader("Content-Type", args.contentType || _defaultContentType);
		xhr.send(null);
	},
	xhrPost: function (args) {
		var xhr = new XMLHttpRequest();
		var _defaultContentType = "application/x-www-form-urlencoded";
		xhr.open("POST", args.url, true);

		xhr.setRequestHeader("Content-Type", args.contentType || _defaultContentType);
		xhr.setRequestHeader("Content-length", args.data.length);
		xhr.setRequestHeader("Connection", "close");

		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4) {
				if (xhr.status == 200) {
					return args.load(xhr.responseText);
				} else {
					return null;
				}
			}
		};
		xhr.send(args.data || null);
	},
	//}}}
	//Components Method {{{
	/*
	 * ccFile create nsIFile(file) object
	 */
	ccFile: function () {
		return this.Cc["@mozilla.org/file/local;1"].createInstance(this.Ci.nsILocalFile);
	},
	/*
	 * ccDir create nsIFile(directory) object
	 */
	ccDir: function (PATH) {
		return this.Cc["@mozilla.org/file/directory_service;1"].getService(this.Ci.nsIProperties).get(PATH || "Home", this.Ci.nsIFile);
	},
	ccProcess: function () {
		return this.Cc["@mozilla.org/process/util;1"].createInstance(this.Ci.nsIProcess);
	},
	/*
	 * append is extended nsIFile.append()
	 * params[:nsIFile] is nsIFile object
	 * second params is name directory or file
	 */
	append: function (file) {
		var path = Array.prototype.slice.call(arguments, 1);
		for (var i = 0; i < path.length; i++) {
			file.append(path[i]);
		}
		return file;
	},
	/*
	  Enumerating files in given directory 
		this method allow you list nsIFile in directory params(nsIFile)
		@params[:nsIFile] is the given directory (nsIFile)
	 */
	ls: function (file) {
		var entries = file.directoryEntries;
		var array = [];
		while (entries.hasMoreElements()) {
			try {
				var entry = entries.getNext();
				entry.QueryInterface(this.Ci.nsIFile);
				array.push(entry);
			} catch(e) {
				return e;
			}
		}
		return array;
	},
	/*READING FROM A FILE
	 *======================================================== */
	/*
	 * Reading local file
	 * file is nsIFile object
	 * ENCOD is encoding file
	 */
	simpleRead: function (file, ENCOD) {
		var data = "",
		fstream = this.fstream(),
		cstream = this.cstream();
		fstream.init(file, -1, 0, 0);
		cstream.init(fstream, ENCOD || "UTF-8", 0, 0);
		//TODO  uncomment when jslint was supported js1.7
		//let (str = {}) {
		//let read = 0;
		//do { 
		//read = cstream.readString(0xffffffff, str);
		//data += str.value;
		//} while (read != 0);
		//}
		(function () {
			var str = {};
			var read = 0;
			do {
				read = cstream.readString(0xffffffff, str); // read as much as we can and put it in str.value
				data += str.value;
			} while (read !== 0);
		})();
		cstream.close(); // this closes fstream
		return data;
	},
	readByLine: function (file) {
		var istream = this.fstream();
		istream.init(file, 0x01, 0444, 0);
		istream.QueryInterface(this.Ci.nsILineInputStream);
		// read lines into array
		var line = {},
		lines = [],
		hasmore;
		do {
			hasmore = istream.readLine(line);
			lines.push(line.value);
		} while (hasmore);

		istream.close();
		return lines;
	},
	/*
	 * Reading asynchronously local file
	 * file is nsIFile object
	 * callback = function(aLoader, aContext, aStatus, aLength, aResult)
	 */
	readFile: function (file, callback) {
		var appInfo = this.Cc["@mozilla.org/xre/app-info;1"].getService(this.Ci.nsIXULAppInfo);
		var isOnBranch = appInfo.platformVersion.indexOf("1.8") === 0;
		var ios = this.ios();
		var fileURI = ios.newFileURI(file);
		var channel = ios.newChannelFromURI(fileURI);
		var sl = this.sl();
		var observer = {
			onStreamComplete: callback
		};
		if (isOnBranch) {
			sl.init(channel, observer, null);
		} else {
			sl.init(observer);
			channel.asyncOpen(sl, channel);
		}
	},
	//}}}
	/*READING FROM A FILE
	 *======================================================== */
	/*
	 * file is nsIFile object
	 */
	writeFile: function (file, data, ENCOD) {
		var foStream = this.fostream();
		// use 0x02 | 0x10 to open file for appending.
		foStream.init(file, 0x02 | 0x08 | 0x20, 0666, 0);
		var converter = this.costream();
		converter.init(foStream, ENCOD || "UTF-8", 0, 0);
		converter.writeString(data);
		converter.close(); // this closes foStream
		return this.simpleRead(file, ENCOD || null);
	},
	StreamToFile: function (file, onStartRequestCallback, onStopRequestCallback, onDataAvailableCallback) {
		var output = this.fostream();
		var buffer = this.buffer();
		output.init(file, 0x02 | 0x08 | 0x20, 0664, null);
		buffer.init(output, 8192);
		return {
			onStartRequest: onStartRequestCallback ||
			function (request, context) {},
			onDataAvailable: onDataAvailableCallback ||
			function onDataAvailable(request, context, stream, offset, count) {
				while (count > 0) {
					count -= buffer.writeFrom(stream, count);
				}
			},
			onStopRequest: onStopRequestCallback ||
			function (request, context) {}
		};
	}
};
//}}}
//app.declare(/*string*/,/*inherited class*/,/*object*/);
App.declare = function (className, superClass, props) {
	if(superClass){
		props.__proto__ = this.isFunction(superClass) ? new superClass() : superClass;
	}
	this.forEach(props.mate,function(key,value){
			if(App.isFunction(value)){
				props.mate[key] = App.hitch(props,value);
			}
	});
	group.commands.add(className.split(','), props.description, this.hitch(props, "onExecute"), props.mate);
	return props;
};

dactyl.plugins.app = App;
