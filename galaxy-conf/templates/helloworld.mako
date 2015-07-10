<%namespace name="ie" file="ie.mako" />

<%
import subprocess
from galaxy.util import sockets
# Sets ID and sets up a lot of other variables
ie_request.load_deploy_config()
ie_request.attr.docker_port = 80
conf = ie_request.get_conf_dict()
## General IE specific
# Access URLs for the notebook from within galaxy.
# http://bag:8080/?bam=http://bag:8080/tmp/bamfile.bam
params = {
    'galaxy_url': ie_request.attr.viz_config.get("docker", "galaxy_url"),
    'galaxy_port': ie_request.attr.PORT
}

notebook_access_url = ie_request.url_template('${PROXY_URL}/')

dataset = ie_request.volume(hda.file_name, '/import/file.txt', how='ro')
# If you'd provided a BAM file, you could also mount the index.
#bam_index = ie_request.volume(hda.metadata.bam_index.file_name, '/input/bamfile.bam.bai', how='ro')

ie_request.launch(env_override={
        #'PUB_HOSTNAME': conf["galaxy_url"],
        #'PUB_HTTP_PORT': ie_request.attr.PORT
    },
    volumes=[dataset]
)
root = h.url_for( '/' )

%>
<html>
<head>
${ ie.load_default_js() }
</head>
<body>

<script type="text/javascript">
${ ie.default_javascript_variables() }
var notebook_login_url = 'unused';
var notebook_access_url = '${ notebook_access_url }';
${ ie.plugin_require_config() }

// Load notebook

requirejs(['interactive_environments', 'plugin/helloworld'], function(){
    load_notebook(ie_password, notebook_login_url, notebook_access_url);
});
</script>
<div id="main" width="100%" height="100%">
</div>
</body>
</html>
