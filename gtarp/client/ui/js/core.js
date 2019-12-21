$(function() {
    dialogs.initialize();
    //gameplay.initialize();
    //jobs.initialize();
    core.initialize();

    // listen for incoming messages
    window.addEventListener("message", function(event) {
         core.receiveMessage(event.data);
    });

    // check for escape key to close menu
    $(document).keyup(function(e) {
         if (e.keyCode == 27 && core.screen) {
              if (dialogs.quantity.isOpen) {
                   dialogs.quantity.cancel();
                   return;
              }

              // tsk tsk, not allowed to close welcome screen with escape. pick a character.
              if (core.screen == welcome) {
                   return;
              }

              //
              core.screen.close();
              core.sendPost("CloseMenu", null);
         }
     });
});

var core = {
     //
     permissions: 0,
     cityAccess: 0,
     characters: null,
     maxCharacters: 8,

     //
     menu: null,
     screens: [],
     screen: null,

     // initialize core systems
     initialize: function() {
          core.setupScreens();
          core.requestAccountInfo();

          //
          console.log("gtarp core js systems online.");
     },

     // setup screen getters
     setupScreens: function() {
          core.registerScreen("ammunation", ammunation);
          core.registerScreen("clerk", ammunation);
          core.registerScreen("ganglands", ganglands);
          core.registerScreen("inventory", inventory);
          core.registerScreen("phone", phone);
          core.registerScreen("welcome", welcome);
     },

     // register a screen and initialize it
     registerScreen: function(name, classObj) {
          this.screens[name] = classObj;
          this.screens[name].initialize();
     },

     // get a specified screen 
     getScreen: function(name) {
          return this.screens[name];
     },

    // request account information from server
    requestAccountInfo: function() {
         // if we got it, stop it!
         if (this.characters !== null)
              return;

         // ask the server for account info 
         core.sendPost("RequestAccountInfo", {});

         // keep doing this until we get our account information
         setTimeout(function() {
              core.requestAccountInfo();
         }, 5000);
    },

     // receive incoming messages from client 
     receiveMessage: function(data) {
          // see if this is a core method first
          if (data.screen === undefined || data.screen === null || data.screen.length == 0) {
               var coreMethod = core[data.method];
               if (coreMethod !== undefined) {
                    console.log("calling core method for " + data.method);
                    coreMethod(data);
               }
               return;
          }
          
          // this must be a screen method then
          var screen = core.getScreen(data.screen);
          if (screen !== undefined) {
               core.screen = screen;

               var methodHandler = screen[data.method];
               if (methodHandler !== undefined) {
                    console.log("calling method handler for " + data.screen + " " + data.method);
                    methodHandler(data);
                    return;
               }
          }
     },

     // send messages to client
     sendPost: function(url, parameters) {
          $.post("http://gtarp/" + url, JSON.stringify(parameters), function(data) {
               console.log(data);
          });
     },

     // CORE EVENTS 

     // received account information
     onSetAccountData: function(data) {
          console.log("set account data.");
          core.permissions = data.permissions;
          core.characters = data.characters;
          core.screen = welcome;

          welcome.open();
     },

     onSetInventory: function(data) {
          inventory.set(data.items, data.weapons, data.cash, data.open);
     }
}