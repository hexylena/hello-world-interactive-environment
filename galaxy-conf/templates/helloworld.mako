<%namespace name="ie" file="ie.mako" />
<%
# Sets ID and sets up a lot of other variables
ie_request.load_deploy_config()
ie_request.attr.import_volume = False

# Launch the IE. This builds and runs the docker command in the background.
ie_request.launch(
    image=trans.request.params.get('image_tag', None),
    additional_ids=trans.request.params.get('additional_dataset_ids', None),
    env_override={
        'custom': '42'
    }
)

# Only once the container is launched can we template our URLs. The ie_request
# doesn't have all of the information needed until the container is running.
url = ie_request.url_template('${PROXY_URL}/helloworld/')
%>
<html>
<head>
${ ie.load_default_js() }
</head>
<body>
<script type="text/javascript">
${ ie.default_javascript_variables() }
var url = '${ url }';
${ ie.plugin_require_config() }
requirejs(['interactive_environments', 'plugin/helloworld'], function(){
    load_notebook(url);
});
</script>
<div id="main" width="100%" height="100%">
</div>
</body>
</html>
