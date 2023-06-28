#!/bin/bash

# # Set configuration variables
# ckan -c /srv/app/ckan.ini config-tool ckan.ini -f /srv/app/scheming.ini

# Following content taken from 
# https://github.com/mjanez/ckan-docker/blob/master/ckan/docker-entrypoint.d/02_setup_scheming.sh

# Update ckanext-scheming and ckanext-facet_scheming settings defined in the env var
echo "Set up ckanext-facet_scheming. Clear index"
ckan -c $CKAN_INI search-index clear

echo "Loading ckanext-scheming and ckanext-facet_scheming settings into ckan.ini"
ckan config-tool $CKAN_INI \
    "scheming.dataset_schemas=$CKANEXT_SCHEMING_DATASET_SCHEMA" \
    "scheming.group_schemas=$CKANEXT_SCHEMING_GROUP_SCHEMA" \
    "scheming.organization_schemas=$CKANEXT_SCHEMING_ORGANIZATION_SCHEMA" \
    "scheming.presets=$CKANEXT_SCHEMING_PRESETS" \
    "facet_scheming.facet_list=$CKANEXT__FACET_FACET_LIST"

echo "ckanext-facet_scheming. Rebuild index"
ckan -c $CKAN_INI search-index rebuild
