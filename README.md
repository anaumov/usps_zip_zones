## USPS zip zones calculator

Ruby implementation of finding zone by origin and destination zip code. implementation uses 'National Zone Charts Matrix Jan 2018'

### How to use?

#### Setup database

`bundle exec rake db:create db:seed_normal db:seed_exception`

#### Run console

`bundle exec bin/console`

#### Check zone!

`bundle exec bin/console`

Normal zone: `ZoneCalculator.call("60510", "20505") => 4`  
Exception zone: `ZoneCalculator.call("96310", "58125") => 7`

You can recheck zone by zip codes [here](https://postcalc.usps.com/DomesticZoneChart).
