#!/bin/bash

ODOO_ENTERPRISE="$ADALABS_ROOT_PATH/GitHub/dsauvage/enterprise"
ADDONS="addons,$ODOO_ENTERPRISE,$ADALABS_ROOT_PATH/odoo-extensions/addons"
DATABASE=odoo-18e
DB_USER=odoo
DB_PASSWORD=admin
DB_HOST=localhost
COMPONENTS=al_documents,al_evouchers,al_hr,al_hr_contract,al_hr_holidays,al_mail,al_monitoring,al_sms_gateway,al_website_sale,al_maintenance

if [ "$1" == "--usage" ]; then
   echo "$0: --init|--shell|--update|--test [module] [component<,component>]"
   echo "$0: no parameters for normal launch"
elif [ "$1" == "--init" ]; then
    python3.12 odoo-bin --addons-path=$ADDONS -d $DATABASE -r $DB_USER -w $DB_PASSWORD --db_host $DB_HOST -i base,web --without-demo=WITHOUT_DEMO
elif [ "$1" == "--test" ]; then
    python3.12 odoo-bin --addons-path=$ADDONS --test-enable --stop-after-init --workers=0 --no-http -r $DB_USER -w $DB_PASSWORD --database=$DATABASE-test --db_host $DB_HOST  -u $2 -i $2 --test-tags /documents:TestDocumentsControllers.test_doc_redirection_partner
# TODO
#  --test-tags /web:MobileWebSuite.test_unit_mobile
# --test-tags /hr_holidays:TestHrHolidaysTour.test_hr_holidays_tour
# --test-tags /hr_holidays:TestLeaveRequests.test_time_off_refusal
# --test-tags /hr_holidays:TestAcessRightsStates.test_reset_confirm_status
# --test-tags /hr_holidays:TestExpiringLeaves.test_allocation_with_max_carryover_and_expiring_allocation
elif [ "$1" == "--update" ]; then
    python3.12 odoo-bin --addons-path=$ADDONS -d $DATABASE -r $DB_USER -w $DB_PASSWORD --db_host $DB_HOST --without-demo=WITHOUT_DEMO -u $COMPONENTS --stop-after-init
elif [ "$1" == "--shell" ]; then
    python3.12 odoo-bin shell --addons-path=$ADDONS -d $DATABASE -r $DB_USER -w $DB_PASSWORD --db_host $DB_HOST --without-demo=WITHOUT_DEMO -u $COMPONENTS
else
    python3.12 odoo-bin --addons-path=$ADDONS -d $DATABASE -r $DB_USER -w $DB_PASSWORD --db_host $DB_HOST --without-demo=WITHOUT_DEMO -u $COMPONENTS
fi
