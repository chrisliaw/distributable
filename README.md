# What is Distributable?

Distributable gem is to assist in creating the framework for the data to be distributed across multiple nodes.

What it does at this version is to:
* Add 'identifier' field to the table structure. This field shall be populated with SecureRandom UUID during record creation and duplication is checked before commit. If you have already has the field defined then the field shall be used.
* Add change_logs table to keep track of which distributable table has changed (added/edited/deleted). These changed record is the target to be synced across to other database later.

### Motivation
This comes when a distributed issue tracking system is being formulated to match the benefit of distributed issue tracker such as Git. Git has numerous value to developer in mobile, such as myself that could allow the source code to be distributed even without a central server. If the Git does not strictly need a central server, we are opted that issue tracker, which tied to the source of the code changed that is translated into the Git commit, should also be distributed to ensure the pace of the issue resolution is in tandem with the Git check ins. 

### Why not just used database that has distributed feature?
There are some RDBMS or NoSQL database do already have high grade distribution feature included such as PostgreSQL, Hadoop, CouchBase etc. However not all database has it. This mainly is to provide consistant distributable feature to the system that is being build without depending on database selection. 

Also using this approach allow more fine grind control on data such that in a database, not all data would be suitable to be synced. One example would be local use access table. Local use access is meant to control which user has what access when the user is connecting to the system. That has no meaning or even harmful to other node as the access rights of a particular user in my node (Imagine you can push your changes to my laptop and your access rights does not mean the same with other team member who is a junior developer that consistantly breaks things).


## Usage
This gem is designed and tested under Rails environment. 

For a particular table that you wish to add to the distributable scope (here the sample table is DistributedRecord):
```ruby
class DistributedRecord < AppicationRecord
	distributable
end
```
and you are done!

Upon record creation, a random SecureRandom UUID shall be inserted into the field identifier and changes would be recorded into the change_logs table created via command
```bash
$ rake distributable:setup
```

You can check if a model is marked as distributable by checking
```ruby
@model.distributed?
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'distributable'
```

And then execute:
```bash
$ bundle
$ rake distributable:setup
```
The rake command only required to execute once per project.

Or install it yourself as:
```bash
$ gem install distributable
```
If you install yourself, after included into the Gemfile, you still required to execute
```bash
$ rake distributable:setup
```

## Contributing
You can contribute by forking the project. Just drop me a message so that I know who's

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
