#!/bin/bash

ODOO_ENTERPRISE="/home/david/dev/odoo-18.0+e.20250403"
ADDONS="$ODOO_ENTERPRISE/odoo/addons,$ADALABS_ROOT_PATH/odoo-extensions/addons"
DATABASE=odoo-18e
DB_USER=odoo
DB_PASSWORD=admin
DB_HOST=localhost
COMPONENTS=al_hr_holidays,

if [ "$1" == "--usage" ]; then
   echo "$0: --init|--shell|--update|--test [module] [component<,component>]"
   echo "$0: no parameters for normal launch"
elif [ "$1" == "--init" ]; then
    python3.12 odoo-bin --addons-path=$ADDONS -d $DATABASE -r $DB_USER -w $DB_PASSWORD --db_host $DB_HOST -i base,web --without-demo=WITHOUT_DEMO
elif [ "$1" == "--test" ]; then
    python3.12 odoo-bin --addons-path=$ADDONS --test-enable --stop-after-init  -r $DB_USER -w $DB_PASSWORD --database=$DATABASE-test --db_host $DB_HOST  -u $2 -i $2
# TODO
# --test-tags /hr_holidays:TestAcessRightsStates.test_reset_confirm_status
elif [ "$1" == "--update" ]; then
    python3.12 odoo-bin --addons-path=$ADDONS -d $DATABASE -r $DB_USER -w $DB_PASSWORD --db_host $DB_HOST --without-demo=WITHOUT_DEMO -u $COMPONENTS --stop-after-init
elif [ "$1" == "--shell" ]; then
    python3.12 odoo-bin shell --addons-path=$ADDONS -d $DATABASE -r $DB_USER -w $DB_PASSWORD --db_host $DB_HOST --without-demo=WITHOUT_DEMO -u $COMPONENTS
else
    python3.12 odoo-bin --addons-path=$ADDONS -d $DATABASE -r $DB_USER -w $DB_PASSWORD --db_host $DB_HOST --without-demo=WITHOUT_DEMO -u $COMPONENTS
fi
