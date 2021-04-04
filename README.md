# orca
Orca manages people and activity subscriptions.

## Development
### Launch
To launch the development environment there are two options. One by
```
cd project-dir
docker-compose up
```

or directly with the VisualStudio Code Dev Container extension.

If you have started the containers, you can access a bash CLI from the running docker containers by executing the following command

```
docker-compose exec app ash
```

### Roles

### Tests
```
docker-compose run app bin/rspec
```

or much faster (if you already have started a container)
```
docker-compose exec app bin/rspec
``` 

### Production
Build

```
docker-compose -f docker-compose.production.yml build production
```

## Environemnt variables
### Developer Stategy
ENVs that have to be set:

### Setup Midata
ENVs that have to be set:

- MIDATA_BASE_URL: The base-url of the hitobito instance to connect to
- MIDATA_USER_EMAIL: The email of the user to connect as
- MIDATA_USER_TOKEN: The token of the user to connect as (not the password). Refer to https://github.com/hitobito/hitobito/blob/master/doc/development/05_rest_api.md
- ROOT_CAMP_UNIT_ID_WOLF: The ID of the root Wolfstufen-Lager
- ROOT_CAMP_UNIT_ID_PFADI: The ID of the root Pfadistufen-Lager
- ROOT_CAMP_UNIT_ID_PIO: The ID of the root Piostufen-Lager
- ROOT_CAMP_UNIT_ID_PTA: The ID of the root Pta-Lager

### Feature Flips

Use the `FEATURES` ENV variable to enable features.

Currently available features are:

- unit_activity_booking


### STORAGE
We use ActiveStorage to store files. To set it up in production use these ENV-Variables:

- STORAGE_SERVICE=azure
- STORAGE_ACCOUNT_NAME=
- STORAGE_ACCESS_KEY=
- STORAGE_CONTAINER=


## Tests

docker-compose exec app bin/rspec
## Database structure
### User roles
- User (`role_user`)
- Admin (`role_admin`)
- Programm (`role_programm`)
  - Activity, Tag, Category
- TN Administration (`role_tn_administration`)
  - Unit, Participant, Leader
- Editor (`role_editor`)
  - Activity

### Code snippets to modify a user: 
```
# Get the first user
bin/rails c
user = User.first
```

# Give a user admin role
user.role_admin = true
user.save

# or
user.update(role_admin: true)

# to remove a role
user.update(role_programm: false)

# Fetch new CampUnits from MiData
bin/rails r "PullNewCampUnitsJob.perform_now"

# Fetch all CampUnits from MiData
bin/rails r "PullAllCampUnitsJob.perform_now"

reload!
```

### Tasks

#### Export Invoices

```ruby
puts InvoiceExporter.new.export
```

```bash
docker-compose run bin/rails r 'puts InvoiceExporter.new.export; STDOUT.flush' > tmp/export.csv
```

## Issues
### Issues when executing orca on Windows based system
When running the docker containers on Windows one common error is that the ports cannot be assigned, because they are used by hyper-v. Using the following commands should resolve this issue: 
```
net stop winnat
docker-compose up
net start winnat
```
