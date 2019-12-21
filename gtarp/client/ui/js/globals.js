var globals = {     
    items: [
         { name: 'water', image: 'iconwater', weight: 0.01 },
         { name: 'soda pop', image: 'iconsodapop', weight: 0.01 },
         { name: 'bag of chips', image: 'iconchips', weight: 0.01 },
         { name: 'coffee', image: 'iconcoffee', weight: 0.01 },
         { name: 'chicken tender', image: 'iconchickentender', weight: 0.01 },
         { name: 'cheeseburger', image: 'iconcheeseburger', weight: 0.01 },
         { name: 'hamburger', image: 'iconhamburger', weight: 0.01 },
         { name: 'double double', image: 'icondoubledouble', weight: 0.01 },
         { name: 'burrito', image: 'iconburrito', weight: 0.01 },
         { name: 'taco', image: 'icontaco', weight: 0.01 },
         { name: 'apple', image: 'iconapple', weight: 0.01 },
         { name: 'banana', image: 'iconbanana', weight: 0.01 },
         { name: 'orange', image: 'iconorange', weight: 0.01 },
         { name: 'grapes', image: 'icongrapes', weight: 0.01 },
         { name: 'weed', image: 'iconweed', weight: 0.01 },
         { name: 'cocaine', image: 'iconcocaine', weight: 0.01 },
         { name: 'meth', image: 'iconmeth', weight: 0.01 },
         { name: 'kilo of weed', image: 'iconweedkilo', weight: 2.0 },
         { name: 'kilo of cocaine', image: 'iconcocainekilo', weight: 2.0 },
         { name: 'kilo of meth', image: 'iconmethkilo', weight: 2.0 },
         { name: 'rolling papers', image: 'iconpapers', weight: 0.01 },
         { name: 'joint', image: 'iconjoint', weight: 0.01 },
         { name: 'meth pipe', image: 'iconmethpipe', weight: 0.01 },
         { name: 'packed meth pipe', image: 'iconpackedmethpipe', weight: 0.5 },
         { name: 'repair kit', image: 'iconrepairkit', weight: 1.0 },
         { name: 'lock pick', image: 'iconlockpick', weight: 0.01 },
         { name: 'hotwire kit', image: 'iconhotwirekit', weight: 0.01 },
         { name: 'metal ore', image: 'iconmetalore', weight: 0.5 },
         { name: 'gold ore', image: 'icongoldore', weight: 0.5 },
         { name: 'gun parts', image: 'icongunparts', weight: 0.01 },
         { name: 'parachute', image: 'iconparachute', weight: 1.0 },
         { name: 'metal bar', image: 'iconmetalbar', weight: 1.0 },
         { name: 'gold bar', image: 'icongoldbar', weight: 1.0 },
         { name: 'wash cloth', image: 'iconwashcloth', weight: 0.01 },
         { name: '40oz', image: 'icon40', weight: 0.01 },
         { name: 'whiskey', image: 'iconwhiskey', weight: 0.01 },
         { name: 'scotch', image: 'iconscotch', weight: 0.01 },
         { name: 'vodka', image: 'iconvodka', weight: 0.01 },
         { name: 'rum', image: 'iconrum', weight: 0.01 },
         { name: 'gin', image: 'icongin', weight: 0.01 },
         { name: 'rotten food', image: 'iconrotten', weight: 0.01 },
         { name: 'fishing pole', image: 'iconfishingpole', weight: 0.01 },
         { name: 'bandage', image: 'iconbandage', weight: 0.01 },
         { name: 'large water', image: 'iconlargewater', weight: 0.01 },
         { name: 'donut', image: 'icondonut', weight: 0.01 },
         { name: 'dirty money', image: 'icondirtymoney', weight: 0.01 },
         { name: 'coca leaf', image: 'iconcoca', weight: 0.01 },
         { name: 'fresh weed', image: 'iconfreshweed', weight: 0.01 },
         { name: 'barred surfperch', image: 'iconbarredfish', weight: 0.01 },
         { name: 'silver surfperch', image: 'iconsilverfish', weight: 0.01 },
    ],

    // weapons 
    weapons: [
         { name: 'weapon_pistol', displayName: 'Pistol', image: 'weapons/handguns/pistol', itemType: 1, price: 500, category: 0, quantity: 10, weight: 2.0 },
         { name: 'weapon_HeavyPistol', displayName: 'Heavy Pistol', image: 'weapons/handguns/HeavyPistol', itemType: 1, price: 650, category: 0, quantity: 10, weight: 2.25 },
         { name: 'weapon_CombatPistol', image: 'weapons/handguns/CombatPistol', itemType: 1, price: 1195, category: 0, quantity: 10, weight: 2.5 },
         { name: 'weapon_SNSPistol', image: 'weapons/handguns/SNSPistol', itemType: 1, price: 350, category: 0, quantity: 10, weight: 2.0 },
         { name: 'weapon_VintagePistol', image: 'weapons/handguns/VintagePistol', itemType: 1, price: 750, category: 0, quantity: 10, weight: 1.75 },
         { name: 'weapon_Revolver', image: 'weapons/handguns/Revolver', itemType: 1, price: 385, category: 0, quantity: 10, weight: 3.0 },

         { name: 'weapon_Knife', image: 'weapons/melee/knife', itemType: 1, price: 50, category: 3, quantity: 10, weight: 0.5 },
         { name: 'weapon_Dagger', image: 'weapons/melee/dagger', itemType: 1, price: 45, category: 3, quantity: 10, weight: 0.5 },
         { name: 'weapon_Machete', image: 'weapons/melee/Machete', itemType: 1, price: 120, category: 3, quantity: 10, weight: 1.25 },
         { name: 'weapon_Flashlight', image: 'weapons/melee/flashlight', itemType: 1, price: 60, category: 3, quantity: 10, weight: 0.5 },

         { name: 'weapon_PumpShotgun', image: 'weapons/shotguns/PumpShotgun', itemType: 1, price: 350, category: 1, quantity: 10, weight: 5.5 },
         { name: 'weapon_Musket', image: 'weapons/shotguns/Musket', itemType: 1, price: 300, category: 1, quantity: 10, weight: 10.0 },
         
         { name: 'weapon_FireExtinguisher', image: 'weapons/Thrown/FireExtinguisher', itemType: 1, price: 25, category: 4, quantity: 10, weight: 3.0 },
         { name: 'weapon_PetrolCan', image: 'weapons/Thrown/PetrolCan', itemType: 1, price: 15, category: 4, quantity: 10, weight: 5.0 },
    ],

    getByIndex: function(index, itemType) {
         var item = itemType == 0 ? globals.item[index] : globals.weapons[index];
         if (item === undefined || item === null){ 
              console.log("image doesn't exist for index " + index);
              return undefined;
         }
         return item;
    },

    // get icon by item name
    getIconByItemName: function(itemName, itemType) {
         var value = null;
         if (itemType == 0) {
              globals.items.forEach(function(item, index, array) {
                   if (item.name.toLowerCase() == itemName.toLowerCase()) {
                        value = item.image;
                        return;
                   }
              });
         } else {
              globals.weapons.forEach(function(item, index, array) {
                   if (item.name.toLowerCase() == itemName.toLowerCase()) {
                        value = item.image;
                        return;
                   }
              });
         }

         if (value === null) {
              return "iconunknown";
         }

         return value;
    }
}