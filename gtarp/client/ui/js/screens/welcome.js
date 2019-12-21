var welcome = {
    $welcome: null,
    $accountLoading: null,
    $characterSlots: [],
    $characterEdit: null,
    $characterSelect: null,
    selectedSlot: -1,

    // initialize the welcome screen
    initialize: function() {
        // cache jquery selectors
        this.$accountLoading = $("#accountLoading");
        this.$welcome = $("#welcome");
        this.$characterEdit = $("#characterEdit");
        this.$characterSelect = $("#characterSelect");

        // loop through available character slots
        for (var i = 0; i < core.maxCharacters; i++) {
            var index = i.toString();
            this.$characterSlots.push($("#characterSlot" + index));
            this.$characterSlots[i].attr("onclick", "welcome.viewCharacter("+ index + ", true);");
        }          
    },

    // open the welcome screen
    open: function(data) {
         for (i = 0; i < core.characters.length; ++i) {
              var c = core.characters[i];
              var slot = this.$characterSlots[i];
              slot.html(c.FirstName + " " + c.LastName);
              slot.attr("onclick", "welcome.viewCharacter(" + i + ", false);");
         }
         this.$accountLoading.hide();
         this.$welcome.show();

         welcome.viewCharacter(0, core.characters.length == 0);
    },

    // close the welcome screen
    close: function() {
        this.$welcome.hide();
    },

    // select a character and view it's information
    viewCharacter: function(slot, isOpenSlot) {    
         for (var i = 0; i < core.maxCharacters; i++) {
              this.$characterSlots[i].css('background-color', 'gray');
         }
         
         var characterSlot = this.$characterSlots[slot];
         characterSlot.css("background-color", "orange");

         this.selectedSlot = slot;

         this.$characterEdit.hide();
         this.$characterSelect.hide();

         if (isOpenSlot) {
              $('#createFirstName').val('');
              $('#createLastName').val('');
              $('#createDateOfBirth').val('');
              $('#createGender').val('');
              $('#createSkin').html('');
              
              $('#charedit').show();
         } else {
              core.character = core.characters[slot];
              
              $('#selectedCharName').html(core.character.FirstName + ' ' + core.character.LastName);
              $('#scCash').html('$' + core.character.Cash.formatMoney());
              $('#scBank').html('$' + core.character.Bank.formatMoney());
              $('#scFines').html('$' + core.character.Fines.formatMoney());
              $('#scCitations').html(core.character.CitationCount);
              $('#scCitations').html(core.character.ArrestCount);
              $('#scServedMonths').html(core.character.TotalJailedTime);
              $('#scNearDeaths').html(core.character.KilledCount);
              $('#scKnockouts').html(core.character.KnockedOutCount);
              $('#charselect').show();
         }    
    },
    
    // select a character to player
    selectCharacter: function() {
        if (core.character === null) 
            return;

        this.$welcome.hide();
        
        var selectedSpawn = $('input[name=spawnGroup]:checked').val();
        core.sendPost("CharacterSelect", { id: core.character.Id, spawnId: selectedSpawn });               
    },

    // player wants to request delete
    requestDelete: function() {
         if (core.character !== null) {
              dialogs.yesNo.show("Are you sure you want to delete that character?",
                   function(value) {                                                
                        if (value) {
                             core.sendPost("CharacterRequestDelete", { characterId: core.character.Id });
                        }
                   });
         }
    }
}