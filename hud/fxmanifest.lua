fx_version 'adamant'

game 'gta5'

ui_page('html/index.html')

files({
	"html/script.js",
	"html/jquery.min.js",
	"html/jquery-ui.min.js",
	"html/styles.css",
	"html/img/*.svg",
	"html/index.html",
})

client_script {
	'client.lua'
}
