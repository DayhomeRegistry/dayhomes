# Day Home Registry

> Day Home Registry is your answer for all of your day home searching needs!
> 
> Being a parent is busy enough. The mission of the Day Home Registry is to make being a parent a little easier.
> 
> _Faye and Jon Holt (Day Home Registry owners)_

This application provides a registry and social platform to connect day homes with each other and with their customers.

## Vocabulary

 * _day home_ - a centre providing care for children. These can be licensed or unclicensed and have different certifications and avilability.

## The Team

* *Jon Holt* - primary support, [jon@dayhomeregistry.com](mailto:jon@dayhomeregistry.com), 780 399 3247, [@jonmholt on Twitter](https://twitter.com/jonmholt), [Google+](https://plus.google.com/104840916888359192970/posts), [jonmholt on GitHub](https://github.com/jonmholt)
* *Mark Bennett* - project management, [mark@burmis.ca](mailto:mark@burmis.ca), 780 826 6275, [@MarkBennett on Twitter](https://twitter.com/MarkBennett), [Google+](https://plus.google.com/104431949275766772757/posts), [MarkBennett on GitHub](https://github.com/MarkBennett)
## Past team members
 * *Nathan Bertram* - development, [nbertram@gmail.com](mailto:nbertram@gmail.com), [@nathanbertram on Twitter](https://twitter.com/nathanbertram), [Google+](https://plus.google.com/118053740037238335612/posts), [GitHub](https://github.com/nathanbertram)
 * *Ryan Jones* - development, [ryan.michael.jones@gmail.com](mailto:ryan.michael.jones@gmail.com), 780 907 2969, [https://twitter.com/ryanonrails], [Google+](https://plus.google.com/108111379110069559271/posts), [ryanonrails on GitHub](https://github.com/ryanonrails)
 * *Vonn Gondziola* - user experience, [vonngondziola@gmail.com](mailto:vonngondziola@gmail.com), 780 237 5654, [@vonnziola on Twitter](https://twitter.com/#!/vonnziola), [Google+](https://plus.google.com/104018711410926928454/posts), [vonziola on GitHub](https://github.com/vonnziola)

## Development Process

All team members coordinate using Pivotal Tracker. It lists all the stories, tasks, bugs, and releases associated with our project in the order in which they should be completed. If you don’t have access to Pivotal Tracker or aren’t sure how to use it, contact mark@burmis.ca.

Day by day, developers should be signing in to Pivotal to find out what the team expects them to work on. If you don’t own any story and have nothing to work on then just start work on the next story listed in Pivotal. If you’re not sure about the next story, or need help deciding what to start next then send an email to the team. Please don’t wait for us to reach out to you if you’ve got nothing to do.

When you start work on a new story, first fetch the latest copy of the project repo from GitHub and then create a new git branch for your work. As you work, commit to the branch as much as necessary and freely push your branch up to GitHub. If your branch exists for more than a day, or as it gets out of sync with the master branch please merge master into your story branch.

Once you’re satisfied that you’ve completed your code push your branch to GitHub. Navigate to the project repo, open your branch and then click the “Pull Request” button. Add any comments you need to explain your change and complete the pull request. The team will be emailed and someone will review your pull request. If they’re satisfied with your changes they can merge your branch into master, otherwise please use the GitHub pull interface to comment and update the branch until the reviewer is satisfied.

*TIP:* If you’re reviewing a pull request, you can use the tabs at the top of the pull request to view the comments, commits, and change summary. You’ll probably want to start with the comments and change summary.

Once the pull request is merged into master, the continuous integration server will automatically run the tests and email the team if anything goes wrong. Assuming everything is working the integration server will deploy your code to the staging server automatically ready for demo to the rest of the team. The integration server will tweet the team to let them know the code has been deployed.

After the change has been merged and the pull request closed, please mark your story as finished and delivered. Well demo the story to the product owner at the next team demo and they’ll either accept it or reject it. Accepted stories will be deployed to production on a schedule set by the client.

To summarize each state transition:

 * _start_ - this means you've cut a branch and begun work on a story
 * _finish_ - this menas your code has been pushed to a branch on GitHub and a pull request has been merged. If it's finished it can be immediately deployed to staging
 * _deliver_ - this story has been deployed to staging and is ready for review
 * _accept_ - this story has been reviewed on staging and is clear for production deployment
 * _reject_ - this story in not accepted and more work needs to be done before it can be deployed to production

## Installing

Before you can run Dayhomes in development, you need to install and be running
the following on your system:

  * MySQL 5.5 (Community Server: http://dev.mysql.com/downloads/mysql/)
	Follow instructions here http://dev.mysql.com/doc/refman/5.5/en/installing.html
  * Redis 2.4.8
	On Windows, this is an interesting step. To date, I've used MSOpenTech's port of redis
			https://github.com/MSOpenTech/Redis
	which can be compiled in Visual Studio (assuming you have the C tools installed)
  * Git >=1.7.10    	
	At least Git 1.7.10 is required because of changes to the SSL mechanism (i.e. openSSL v1.??)
  * ImageMagick
	In Windows, ImageMagick installed installed by default and the mini_magick gem doesn't load
	it as a dependency. Grab binaries here:
		http://www.imagemagick.org/script/binary-releases.php#windows

Begin by cloning the dayhomes repository from GitHub to get access to the
projects source code and build assets.

    git clone git@github.com:burmis/dayhomes.git
    cd dayhomes
    
Depending on your setup you then need to install ruby with RVM:

    rvm use --create 1.9.3-p125@dayhomes

Or install it using rbenv:

    rbenv install 1.9.3-p125@dayhomes
	
Or install it using RubyInstaller.org
	
	http://rubyforge.org/frs/download.php/75848/rubyinstaller-1.9.3-p125.exe	
	
	## Note
	For the moment, you're going to need to use 1.9.3-p125 because p194 has a conflict with 
	the latest build of the EventMachine gem on Windows.
	
	You also need the DevKit, which can be found here:
	 	https://github.com/downloads/oneclick/rubyinstaller/DevKit-tdm-32-4.5.2-20111229-1559-sfx.exe
	follow instructions here:
		https://github.com/oneclick/rubyinstaller/wiki/Development-Kit

If you have created a new Ruby install you may need to install the Bundler gem.
Bundler uses a Gemfile to manage the dependencies of our application.

    gem install bundler

Once Bundler is installed, install the gems our project depends on with:

    bundle install --binstubs
	
On Windows, you may want to disable https for rubygems, YMMV, but to prevent nix explosions:

	bundle install --without production

The default install of MySQL seems to pull the wrong mysql driver, so you'll want to grab the MySQL Connector 6.0.2:

	mysql-connector-c-noinstall-6.0.2-win32.zip

	## Note
	I had to use the 32bit version despite being on a 64bit machine...seems to be a known bug
	
The archive contains lib/libmysql.dll which needs to be copied to the %Ruby_home%/bin directory.
	
Once the software dependencies are installed we need to configure the database.
If you haven't already you'll need to install MySQL before continuing.

MySQL on windows with rake is a tricky bugger.  In the MySQL ini file, you're going to need to specify the bind-address 
	# The MySQL server
	> [mysqld]
	> ...
	> bind-address	= localhost
	> ...

You need to create your database configuration file in <tt>config/database.yml</tt>:
    cp config/database.yml.template config/database.yml
	
The user credentials you enter in this file need to be able to create and admin the dev
and test databases. In addition, you're going to need to set
	host: 127.0.0.1
since localhost	gets translated to its corresponding IPv4 address in MySQL.

Once all that is configured, you need to setup your database locally
    
    rake db:create
    rake db:setup
	rake db:seed:samples

You'll also want to prepare the test database with:

    bin/rake db:test:prepare

## Running the app

We're using the Foreman gem to manage our application processes. Kick off the
application with:

    bin/foreman start	

Since foreman doesn't seem to work on Windows at this point, you can also start the app the old fashioned way using:
	rails server
	
Please note that MySQL and redis should be running as described in the
prerequisites section.

## Running the tests

Our app ships with a large set of tests. You can run the full suite using:

    bin/rake spec

It's also possible to monitor and run tests as you work using the guard gem:

    bin/guard

This will run tests on individual files as changes are made.

## Gmaps notes

Asset generate for prod: rails generate gmaps4rails:install
