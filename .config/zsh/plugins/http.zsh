[[ -z $HTTP_FORMAT_JSON ]] && HTTP_FORMAT_JSON=application/json
[[ -z $HTTP_FORMAT_HTML ]] && HTTP_FORMAT_HTML=text/html


get() {
    [[ -z $1 ]] && echo "No parameters provided." && return

    mapping_var=HTTP_FORMAT_${1:u}
    content_type=${(P)mapping_var}

    [[ -z $content_type ]] && curl $@ && return

    curl --header "'Accept: ${content_type}'" $@[2,-1]
}
