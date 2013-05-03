//AUTHOR:  Maksim Ryzhikov
//NAME:    splitter (Spider)
//VERSION  1.3
var app = dactyl.plugins.app;

/*
 *Frame constructor function
 */
var Frame = function (url, opts) {
	//mixining options for frame
	var options = app.mixin({
		builder: window.content.document,
		src: url,
		width: "100%",
		height: "100%"
	},
	opts || {});
	return app.create("frame", options); //return node frame
};

/*
 * Spider is controling behavior tab
 * Spider is 'Divided Tab'
 */
var Spider = function (doc) {
	this.doc = doc;
	this.frames = [];
};

var _proto_ = {
	constructor: Spider,
	_afterFilter: function (frame, url) {
		var frames = this.frames;
		frames.push({
			node: frame,
			uri: url,
			index: frames.length
		});
		return frames;
	},
	_reindex: function () {
		app.forEach(this.frames, function (f, i) {
			f.node.name = "split" + i;
			f.index = i;
		},
		this);
	},
	getActiveElement: function () {
		return this.doc.activeElement;
	},
	//FIXME rewrite
	initialize: function () {
		var doc = this.doc;
		var url = doc.location.href; //save link on current page
		this.container = app.create("frameset", {
			builder: doc
		});
		var html = doc.body.parentNode;
		html.replaceChild(this.container, doc.body); //replace body on frameset
		this.split(url).contentWindow.location.href = url; //insert link on current page in frame (hack)
	},
	split: function (url) {
		var ct = this.container; //container frameset
		var frame = new Frame(url, {
			name: "split" + this.frames.length
		});
		app.place(frame, ct);
		var fs = this._afterFilter(frame, url); //frames
		ct.cols = app.multi("*", fs.length).split('').join(',');
		return frame;
	},
	onFocus: function (evt) {
		var target = this.getActiveElement();
		app.console.log(target);
		//var target = this.getActiveElement();
		//app.forEach(this.frames, function (f) {
			//f.node.style.opacity = 1;
			//if (f.node != target) {
				//f.node.style.opacity = 0.5;
			//}
		//},
		//this);
	},
	close: function (url) {
		var frames = this.frames,
		uri = url || this.getActiveElement().src; //FIXME bug in first time
		var frame = app.filter(frames, function (f) {
			return f.uri == uri;
		},
		this)[0];
		if (frame.node) {
			var cols = this.container.cols.split(',');
			var delNode = this.container.removeChild(frame.node);
			cols.splice(frame.index, 1);
			frames.splice(frame.index, 1);
			this.container.cols = cols.join(',');
			this._reindex();
		}
		return frame.node;
	},
	toggle: function (url) {
		var uri = url || this.getActiveElement().src;
		var frame = app.filter(this.frames, function (f) {
			return f.uri == uri;
		},
		this)[0];
		if (frame.node) {
			var cols = this.container.cols.split(',');
			cols[frame.index] = (cols[frame.index] === "0") ? "*": 0;
			this.container.cols = cols.join(',');
		}
		return frame.node;
	},
	completer: function () {
		var compl = [];
		app.forEach(this.frames, function (item) {
			compl.push([item.uri, item.index]);
		},
		this);
		return compl;
	}
};
Spider.prototype = _proto_;

/*
 * Controller is controling all Spiders(Tabs)
 */
var controller = {
	tabs: [],
	currentTab: null,
	beforeFilter: function (doc) {
		return app.filter(this.tabs, function (t) {
			return t.doc == doc;
		},
		this)[0];
	},
	doSetup: function (doc, url) {
		var tab = new Spider(doc);
		tab.initialize();
		this.tabs.push(tab);
		return tab.split(url);
	},
	doSplit: function (url, tab) {
		url = url || window.content.document.URL;
		return tab.split(url);
	},
	doClose: function (url, tab) {
		tab.close(url);
	},
	doTurn: function (url, tab) {
		tab.toggle(url);
	},
	doPull: function (url, doc) {
		return this.doSplit(url, doc);
	},
	actions: function (url, action, doc) { //actions with windows in current page
		var doct = doc || window.content.document,
		f; //initialize current document
		var tab = this.beforeFilter(doct); //before filter
		if (!tab) {
			f = this.doSetup(doct, url);
			return f;
		}
		/*
		 * switch actions
		 */
		f = this['do' + app.capitalize(action)](url, tab);
		return f;
	},
	completer: function (context) {
		var compl, doc = window.content.document,
		tab = controller.beforeFilter(doc);
		if (tab) {
			compl = tab.completer();
			context.completions = compl;
		}
	}
};

group.commands.add(["spid[er]"], "Split Window", function (args) {
	var option = app.filter(this.options, function (option) {
		var a = args[option.names[0]] || args[option.names[1]];
		return !! a;
	},
	this)[0];

	if (option) {
		var a = args[option.names[0]] || args[option.names[1]];
		controller.actions(a, option.names[0].slice(1));
	} else {
		var URL = window.content.document.URL;
		var s = (args.length > 0) ? controller.actions(args[0], "split") : controller.actions(URL, "split").contentWindow.location.href = URL;
	}
},
{
	argCount: "?",
	completer: function (context, maxitems, sort) {
		completion.url(context);
	},
	options: [{
		names: ["-close", "-C"],
		description: "Close window",
		type: commands.OPTION_STRING,
		completer: function (context) {
			controller.completer(context);
		}
	},
	{
		names: ["-turn", "-T"],
		description: "Turn window",
		type: commands.OPTION_STRING,
		completer: function (context) {
			controller.completer(context);
		}
	},
	{
		names: ["-pull", "-P"],
		description: "Pull open tabs in current page",
		completer: function (context, args) {
			var mtabs = dactyl.modules.tabs;
			var tabs = mtabs.getGroups().AllTabs.tabs,
			compl = [];
			app.forEach(tabs, function (i, tab) {
				var label = tab.label;
				var url = tab.linkedBrowser._contentWindow.document.location.href;
				compl.push([url, label]);
			},
			this);
			context.completions = compl;
		},
		type: commands.OPTION_STRING
	}]
});

group.mappings.add([modes.NORMAL], [";ss"], "Split Window", function () {
	var URL = window.content.document.URL;
	controller.actions(URL, "split").contentWindow.location.href = URL;
});
group.mappings.add([modes.NORMAL], [";sc"], "Close Split Window", function () {
	controller.actions(null, "close");
});
