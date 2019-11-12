# Hacking

These are some best-effort notes on how work on Heimdall.

## Setup

### With docker-compose

There's a docker-compose.yml file in the root of the repo
that will run Heimdall inside a sparse Apline-based environment.

You'll need `docker` and `docker-compose` to use this environment

To get started:

1. `docker-compose up`
1. Open [localhost:8000](http://localhost:8000) in your browser.
   *Ignore the message in your terminal about 0.0.0.0:8000 - it won't work*.

To reset your development environment:

1. `docker-compose down`
1. `rm .env`
1. `rm ./database/app.sqlite`

### pre-build development image

You may be able to use the `linuxserver/heimdall:development` image to develop
Heimdall, but it's not obvious how to.

## Overview

### Settings

Models: Setting, SettingGroup, SettingUser

#### Setting

This model defines what settings can be changed for a user in Heimdall.
Settings are created by database/seeds/SettingsSeeder.php, and are immutable after creation.
You can modify the seeder and then reset your development environment to add
new rows to the settings UI.

#### SettingGroup

SettingGroup defines the sections in the settings UI.
SettingGroups are created by database/seeds/SettingsSeeder.php, and are immutable after creation.

#### SettingUser

When a user changes a setting, a new SettingUser model is created to store the user's change.

### Items

Items represent both user-defined application bookmarks and user-defined tags. 
Items with `$item->type === 1` are tags, and link to their own edit page.

Items with `$item->type === 0` are items, and link out to their bookmark URL.
Items representing a supported app have `$item->class` defined to point to one
of the classes inside app/SupportedApps.

### SupportedApps

The SupportedApps directory holds PHP classes, images, and JSON descriptions of
all the applications that Heimdall knows about.

#### Jobs/ProcessApps.php

This job updates the SupportedApps from [apps.hiemdall.site/list](https://apps.heimdall.site/list).
The list of remote apps is compared against the local apps currently in the database.
For any app that doesn't exist locally, or that has a different `$app->sha`, the app
source code and images are downloaded and imported from https://apps.heimdall.site/files/SHA/file.zip
