// various dialogs used within the game
var dialogs = {
    initialize: function() {
         dialogs.yesNo.initialize();
         dialogs.quantity.initialize();

         console.log("gtarp dialogs initialized.");
    },


    // simple yes or no dialog
    yesNo: {
         mainControl: null,
         messageControl: null,
         callback: null,

         initialize: function() {
              this.mainControl = $("#yesNoDialog");
              this.messageControl = $("#yesNoMessage");
         },

         show: function(message, cb) {
              this.callback = cb;
              this.messageControl.html(message);
              this.mainControl.show();
         },

         hide: function() {
              this.messageControl.html("");
              this.mainControl.hide();
              this.callback = null;
         },

         yes: function() {
              this.callback(true);
              this.hide();
         },

         no: function() {
              this.callback(false);
              this.hide();
         }
    },

    // quantity dialog controller
    quantity: {
         isOpen: false,
         dialogControl: null,
         messageControl: null,
         quantityControl: null,
         maxQuantityControl: null,
         callback: null,

         initialize: function() {
              dialogControl = $("#quantity");
              messageControl = $("#quantityMessage");
              quantityControl = $("#quantityAmount");
              maxQuantityControl = $("#quantityMaxAmount");
         },
         show: function(message, maxQuantity, cb) {
              messageControl.html(message);
              maxQuantityControl.html(maxQuantity);
              quantityControl.val(1);
              dialogControl.show();
              callback = cb;
              isOpen = true;
         },
         complete: function() {
              var quantity = quantityControl.val();
              if (isNaN(quantity) || quantity < 0 || quantity > 10000000)
                   quantity = 1;

              if (callback !== undefined) {
                   callback(quantity);
              }

              callback = null;
              dialogControl.hide();
              isOpen = false;
         },
         cancel: function() {
              dialogControl.hide();
              isOpen = false;
         }
    }     
}