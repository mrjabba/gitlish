require 'test/unit'
require './gitlish'
require 'mocha'

class TestService < Test::Unit::TestCase

  def test_retrieve

    @data = <<-eos
    {"repositories":[{"description":"The first app for Ruby on Rails Tutorial","forks":1,"has_issues":true,"url":"https://github.com/someuser/first_app","homepage":"","has_downloads":true,"fork":false,"created_at":"2010/09/25 07:50:07 -0700","watchers":1,"private":false,"name":"first_app","owner":"someuser","has_wiki":true,"open_issues":0,"pushed_at":"2010/09/25 08:00:14 -0700"},{"description":"Ruby on Rails Tutorial demo application","forks":1,"has_issues":true,"url":"https://github.com/someuser/demo_app","homepage":"","has_downloads":true,"fork":false,"created_at":"2010/10/03 08:56:03 -0700","watchers":1,"private":false,"name":"demo_app","owner":"someuser","has_wiki":true,"open_issues":0,"pushed_at":"2010/10/03 09:01:45 -0700"}]}
    eos

    service = Gitlish::Client.new("mrjabba", "mrjabba", "somepass")
    #Mock just the retrieve method
    service.stubs(:github_retrieve).returns(@data)
    @list = service.github_retrieve_list()

    assert_not_nil @list
    assert_equal 2, @list.size

    assert_equal "someuser", @list[0].owner
    assert_equal "first_app", @list[0].name
    assert_equal "https://github.com/someuser/first_app", @list[0].url
    assert_equal "The first app for Ruby on Rails Tutorial", @list[0].description

  end

  def test_delish
    #This doesnt really test anyting. Remove it?
    # Also, rdelicious is_connected doesn't seem to really work.
    service = Gitlish::Client.new("mrjabba", "mrjabba", "zzzz")
    @list = []
    repo1 = Gitlish::Repo.new
    repo1.name = "reponame1"
    repo1.username = "username1"
    repo1.url = "http://foo1"
    repo1.owner = "someuser1"
    repo1.description = "description1"

    repo2 = Gitlish::Repo.new
    repo2.name = "reponame2"
    repo2.username = "username2"
    repo2.url = "http://foo2"
    repo2.owner = "someuser2"
    repo2.description = "description2"
    @list.push(repo1)
    @list.push(repo2)
    
    service.publish_delish(@list)

    #assert stuff    

  end

end
