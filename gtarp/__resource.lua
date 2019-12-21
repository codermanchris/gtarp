resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description 'GTARP'
version '2.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'globals.lua',

    -- class definitions
    'server/core/classes/account.lua',
    'server/core/classes/character.lua',
    'server/core/classes/vehicle.lua',

    -- core managers
    'server/core/_common.lua',
    'server/core/accounts.lua',
    'server/core/events/accounts.events.lua',
    'server/core/characters.lua',
    'server/core/events/characters.events.lua',
    'server/core/commands.lua',
    'server/core/connection.lua',
    'server/core/core.lua',
    'server/core/core.events.lua',
    'server/core/helpers.lua',
    'server/core/jobs.lua',
    'server/core/events/jobs.events.lua',
    'server/core/vehicles.lua',
    'server/core/weather.lua',
    
    -- gameplay
    'server/gameplay/_common.lua',
    'server/gameplay/apartment.lua',
    'server/gameplay/apartment.events.lua',
    'server/gameplay/bank.lua',
    'server/gameplay/bank.events.lua',
    'server/gameplay/business.lua',
    'server/gameplay/business.events.lua',
    'server/gameplay/carwash.lua',
    'server/gameplay/carwash.events.lua',
    'server/gameplay/clothingstore.lua',
    'server/gameplay/clothingstore.events.lua',
    'server/gameplay/dmv.lua',
    'server/gameplay/dmv.events.lua',
    'server/gameplay/drivethrough.lua',
    'server/gameplay/drivethrough.events.lua',
    'server/gameplay/drugprocessor.lua',
    'server/gameplay/drugprocessor.events.lua',
    'server/gameplay/fbi.lua',
    'server/gameplay/fbi.events.lua',
    'server/gameplay/fishing.lua',
    'server/gameplay/fishing.events.lua',
    'server/gameplay/flightschool.lua',
    'server/gameplay/flightschool.events.lua',
    'server/gameplay/ganglands.lua',
    'server/gameplay/ganglands.events.lua',
    'server/gameplay/garage.lua',
    'server/gameplay/garage.events.lua',
    'server/gameplay/hospital.lua',
    'server/gameplay/hospital.events.lua',
    'server/gameplay/house.lua',
    'server/gameplay/house.events.lua',
    'server/gameplay/mechanicshop.lua',
    'server/gameplay/mechanicshop.events.lua',
    'server/gameplay/moneytruck.lua',
    'server/gameplay/moneytruck.events.lua',
    'server/gameplay/prison.lua',
    'server/gameplay/prison.events.lua',
    'server/gameplay/simeons.lua',
    'server/gameplay/simeons.events.lua',
    'server/gameplay/store.lua',
    'server/gameplay/store.events.lua',
    'server/gameplay/tattooparlor.lua',
    'server/gameplay/tattooparlor.events.lua',
    'server/gameplay/taxi.lua',
    'server/gameplay/taxi.events.lua',
    'server/gameplay/vehiclemarket.lua',
    'server/gameplay/vehiclemarket.events.lua',
    'server/gameplay/vehiclerental.lua',
    'server/gameplay/vehiclerental.events.lua',

    -- jobs
    'server/jobs/_common.lua',
    'server/jobs/boatdelivery.lua',
    'server/jobs/boatdelivery.events.lua',
    'server/jobs/busdriver.lua',
    'server/jobs/busdriver.events.lua',
    'server/jobs/clerk.lua',
    'server/jobs/clerk.events.lua',
    'server/jobs/courier.lua',
    'server/jobs/courier.events.lua',
    'server/jobs/cropdustpilot.lua',
    'server/jobs/cropdustpilot.events.lua',
    'server/jobs/doctor.lua',
    'server/jobs/doctor.events.lua',
    'server/jobs/drugdelivery.lua',
    'server/jobs/drugdelivery.events.lua',
    'server/jobs/farmer.lua',
    'server/jobs/farmer.events.lua',
    'server/jobs/gopostal.lua',
    'server/jobs/gopostal.events.lua',
    'server/jobs/mechanic.lua',
    'server/jobs/mechanic.events.lua',
    'server/jobs/medic.lua',
    'server/jobs/medic.events.lua',
    'server/jobs/miner.lua',
    'server/jobs/miner.events.lua',
    'server/jobs/pizzadelivery.lua',
    'server/jobs/pizzadelivery.events.lua',
    'server/jobs/police.lua',
    'server/jobs/police.events.lua',
    'server/jobs/security.lua',
    'server/jobs/security.events.lua',
    'server/jobs/skydivingpilot.lua',
    'server/jobs/skydivingpilot.events.lua',
    'server/jobs/tacos.lua',
    'server/jobs/tacos.events.lua',
    'server/jobs/taxidriver.lua',
    'server/jobs/taxidriver.events.lua',
    'server/jobs/tow.lua',
    'server/jobs/tow.events.lua',
    'server/jobs/transportpilot.lua',
    'server/jobs/transportpilot.events.lua',
    'server/jobs/trucker.lua',
    'server/jobs/trucker.events.lua'
}

client_scripts {
    'globals.lua',

    -- core
    'client/core/_common.lua',
    'client/core/threads.lua',
    'client/core/chat.lua',
    'client/core/core.lua',
    'client/core/events/core.events.lua',
    'client/core/localplayer.lua',
    'client/core/events/localplayer.events.lua',
    'client/core/ui.lua',
    'client/core/vehicle.lua',
    'client/core/events/vehicle.events.lua',
    'client/core/weather.lua',
    'client/core/events/weather.events.lua',

    -- gameplay
    'client/gameplay/_common.lua',
    'client/gameplay/apartment.lua',
    'client/gameplay/apartment.events.lua',
    'client/gameplay/bank.lua',
    'client/gameplay/bank.events.lua',
    'client/gameplay/business.lua',
    'client/gameplay/business.events.lua',
    'client/gameplay/carwash.lua',
    'client/gameplay/carwash.events.lua',
    'client/gameplay/clothingstore.lua',
    'client/gameplay/clothingstore.events.lua',
    'client/gameplay/dmv.lua',
    'client/gameplay/dmv.events.lua',
    'client/gameplay/drivethrough.lua',
    'client/gameplay/drivethrough.events.lua',
    'client/gameplay/drugprocessor.lua',
    'client/gameplay/drugprocessor.events.lua',
    'client/gameplay/fbi.lua',
    'client/gameplay/fbi.events.lua',
    'client/gameplay/fishing.lua',
    'client/gameplay/fishing.events.lua',
    'client/gameplay/flightschool.lua',
    'client/gameplay/flightschool.events.lua',
    'client/gameplay/ganglands.lua',
    'client/gameplay/ganglands.events.lua',
    'client/gameplay/garage.lua',
    'client/gameplay/garage.events.lua',
    'client/gameplay/hospital.lua',
    'client/gameplay/hospital.events.lua',
    'client/gameplay/house.lua',
    'client/gameplay/house.events.lua',
    'client/gameplay/mechanicshop.lua',
    'client/gameplay/mechanicshop.events.lua',
    'client/gameplay/moneytruck.lua',
    'client/gameplay/moneytruck.events.lua',
    'client/gameplay/prison.lua',
    'client/gameplay/prison.events.lua',
    'client/gameplay/simeons.lua',
    'client/gameplay/simeons.events.lua',
    'client/gameplay/store.lua',
    'client/gameplay/store.events.lua',
    'client/gameplay/tattooparlor.lua',
    'client/gameplay/tattooparlor.events.lua',
    'client/gameplay/taxi.lua',
    'client/gameplay/taxi.events.lua',
    'client/gameplay/vehiclemarket.lua',
    'client/gameplay/vehiclemarket.events.lua',
    'client/gameplay/vehiclerental.lua',
    'client/gameplay/vehiclerental.events.lua',

    -- jobs
    'client/jobs/_common.lua',
    'client/jobs/boatdelivery.lua',
    'client/jobs/boatdelivery.events.lua',
    'client/jobs/busdriver.lua',
    'client/jobs/busdriver.events.lua',
    'client/jobs/clerk.lua',
    'client/jobs/clerk.events.lua',
    'client/jobs/courier.lua',
    'client/jobs/courier.events.lua',
    'client/jobs/cropdustpilot.lua',
    'client/jobs/cropdustpilot.events.lua',
    'client/jobs/doctor.lua',
    'client/jobs/doctor.events.lua',
    'client/jobs/drugdelivery.lua',
    'client/jobs/drugdelivery.events.lua',
    'client/jobs/farmer.lua',
    'client/jobs/farmer.events.lua',
    'client/jobs/gopostal.lua',
    'client/jobs/gopostal.events.lua',
    'client/jobs/mechanic.lua',
    'client/jobs/mechanic.events.lua',
    'client/jobs/medic.lua',
    'client/jobs/medic.events.lua',
    'client/jobs/miner.lua',
    'client/jobs/miner.events.lua',
    'client/jobs/pizzadelivery.lua',
    'client/jobs/pizzadelivery.events.lua',
    'client/jobs/police.lua',
    'client/jobs/police.events.lua',
    'client/jobs/security.lua',
    'client/jobs/security.events.lua',
    'client/jobs/skydivingpilot.lua',
    'client/jobs/skydivingpilot.events.lua',
    'client/jobs/tacos.lua',
    'client/jobs/tacos.events.lua',
    'client/jobs/taxidriver.lua',
    'client/jobs/taxidriver.events.lua',
    'client/jobs/tow.lua',
    'client/jobs/tow.events.lua',
    'client/jobs/transportpilot.lua',
    'client/jobs/transportpilot.events.lua',
    'client/jobs/trucker.lua',
    'client/jobs/trucker.events.lua'    
}

ui_page {
	'client/ui/ui.html'
}

files {
    'client/ui/ui.html',

    -- css
    'client/ui/css/base.css',

    -- javascript files
    'client/ui/js/jquery-3.4.1.min.js',
    'client/ui/js/globals.js',
    'client/ui/js/dialogs.js',
    'client/ui/js/core.js',

    -- ui screens
    'client/ui/js/screens/ammunation.js',
    'client/ui/js/screens/clerk.js',
    'client/ui/js/screens/ganglands.js',
    'client/ui/js/screens/inventory.js',
    'client/ui/js/screens/phone.js',
    'client/ui/js/screens/welcome.js',

    -- phone apps
    'client/ui/js/screens/apps/app.bank.js',
    'client/ui/js/screens/apps/app.call.js',
    'client/ui/js/screens/apps/app.contacts.js',
    'client/ui/js/screens/apps/app.home.js',
    'client/ui/js/screens/apps/app.insurance.js',
    'client/ui/js/screens/apps/app.internet.js',
    'client/ui/js/screens/apps/app.linux.js',
    'client/ui/js/screens/apps/app.messages.js',
    'client/ui/js/screens/apps/app.moejack.js',
    'client/ui/js/screens/apps/app.moeslist.js',
    'client/ui/js/screens/apps/app.ncic.js',
    'client/ui/js/screens/apps/app.realtor.js',
    'client/ui/js/screens/apps/app.simeons.js',
    'client/ui/js/screens/apps/app.twitter.js',
    'client/ui/js/screens/apps/app.uber.js',
    'client/ui/js/screens/apps/app.vehiclemarket.js',
    'client/ui/js/screens/apps/app.xracer.js'
}