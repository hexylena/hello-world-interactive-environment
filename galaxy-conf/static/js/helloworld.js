/**
 * Load an interactive environment (IE) from a remote URL
 * @param {String} password: password used to authenticate to the remote resource
 * @param {String} notebook_login_url: URL that should be POSTed to for login
 * @param {String} notebook_access_url: the URL embeded in the page and loaded
 *
 */
function load_notebook(password, notebook_login_url, notebook_access_url){
    $( document ).ready(function() {
        // Test notebook_login_url for accessibility, executing the login+load function whenever
        // we've successfully connected to the IE.
        test_ie_availability(notebook_login_url, function(){
            _handle_notebook_loading(password, notebook_login_url, notebook_access_url);
        });
    });
}

/**
 * Must be implemented by IEs
 */
function _handle_notebook_loading(password, notebook_login_url, notebook_access_url){
    append_notebook(notebook_access_url);
}
