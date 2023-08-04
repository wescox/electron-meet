const { app, BrowserWindow } = require('electron')

// Global variable that holds the app window
let win

function createWindow() {

// Creating the browser window
win = new BrowserWindow({
	width: 1080,
	height: 1080,
})

// Load a redirecting url from
// login to the feed
win.loadURL(
process.argv[2])

win.on('closed', () => {
	win = null
})

// Prevent from spawning new windows
win.webContents.on('new-window', (event, url) => {

	event.preventDefault()
	win.loadURL(url)
})
}

// Executing the createWindow function
// when the app is ready
app.on('ready', createWindow)

