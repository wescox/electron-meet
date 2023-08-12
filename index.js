const { app, BrowserWindow, desktopCapturer } = require('electron')

// Global variables
let win;
//let url = process.argv[2];
let url = "https://meet.google.com/"

function createWindow() {

	// Creating the browser window
	win = new BrowserWindow({
		width: 1080,
		height: 1080,
	});

	// Remove menu
	win.setMenuBarVisibility(false);

	// Load a redirecting url from login to the feed
	win.loadURL(url); //url passed from shell script
	
	win.on('closed', () => {
		win = null
	});

	// Prevent from spawning new windows
	win.webContents.on('new-window', (event, url) => {
		event.preventDefault();
		win.loadURL(url);
	});
}

// this is the start of figuring out how to screen share
// app.whenReady().then(() => {
// 	desktopCapturer.getSources({ types: ['window', 'screen'] }).then(async sources => {
// 		for (const source of sources) {
// 			console.log(source);
// 			if (source.name === 'Electron') {
// 			mainWindow.webContents.send('SET_SOURCE', source.id)
// 			return
// 			}
// 		}
// 	});
// });

app.whenReady().then(() => {
	session.defaultSession.setDisplayMediaRequestHandler((request, callback) => {
		desktopCapturer.getSources({types: ['screen']}).then((sources) => {
			callback({video: sources[0]});
		});
	});
});

// Executing the createWindow function
// when the app is ready
app.on('ready', createWindow)



