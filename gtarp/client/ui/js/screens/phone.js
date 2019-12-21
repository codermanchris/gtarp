var phone = {
     hasPhone: true, 
     hasAccess: true,

     $phone: null,
     apps: [],
     app: null, // currently selected app

     initialize: function() {
          this.$phone = $("#phone");

          // register phone applications
          phone.registerApp("bank", appBank);
          phone.registerApp("call", appCall);
          phone.registerApp("contacts", appContacts);
          phone.registerApp("home", appHome);
          phone.registerApp("insurance", appInsurance);
          phone.registerApp("internet", appInternet);
          phone.registerApp("linux", appLinux);
          phone.registerApp("messages", appMessages);
          phone.registerApp("moejack", appMoejack);
          phone.registerApp("moeslist", appMoeslist);
          phone.registerApp("ncic", appNCIC);
          phone.registerApp("realtor", appRealtor);
          phone.registerApp("simeons", appSimeons);
          phone.registerApp("twitter", appTwitter);
          phone.registerApp("uber", appUber);
          phone.registerApp("vehiclemarket", appVehicleMarket);
          phone.registerApp("xracer", appXRacer);
     },

     open: function(data) {
          if (!this.hasPhone || !this.hasAccess) {
               console.log("you don't have a phone or you can't access it.");
               return;
          }

          this.openApp("home");
          this.$phone.show();          
     },

     close: function() {
          this.$phone.hide();
     },

     openApp: function(appName, data) {
          if (!this.hasPhone || !this.hasAccess) {
               console.log("you don't have a phone or you can't access it.");
               return;
          }

          this.closeApp();

          this.app = this.getApp(appName);
          if (this.app === undefined) {
               console.log("invalid phone application.");
               return;
          }

          this.app.open(data);
     },

     closeApp: function() {
          if (this.app === null || this.app === undefined)
               return;
          this.app.close();
     },

     getApp: function(name) {
          return this.apps[name];
     },

     // register a screen and initialize it
     registerApp: function(name, classObj) {
          this.apps[name] = classObj;
          this.apps[name].initialize();
     }
}