require "net/http"
require "uri"
require 'json'
require 'rdelicious'

module Gitlish
  #Example result: http://www.delicious.com/mrjabba/gitlish

  class Repo
    attr_accessor :name, :url, :owner, :description, :username
  end

  class Client
    attr_accessor :git_name
 
    def initialize(git_name,delish_name,delish_pass)
      self.git_name = git_name
      @gitlish_tag = "gitlish"
      @d = Rdelicious.new(delish_name, delish_pass)
    end

    def github_retrieve()
      #raw example: curl http://github.com/api/v2/yaml/repos/watched/mrjabba
      @uri = URI.parse("http://github.com/api/v2/json/repos/watched/" + git_name)
      Net::HTTP.get(@uri)
    end

    def github_retrieve_list()
      @data = github_retrieve()
      @results = JSON.parse(@data)["repositories"]	
      @list = []
      @results.each {|item| 
        repo = Repo.new
        repo.name = item["name"]
        repo.username = git_name
        repo.url = item["url"]
        repo.owner = item["owner"]
        repo.description = item["description"]
        @list.push(repo)
      }
      @list
    end

    def publish_delish(repo_list)
      if repo_list != nil
        count = 0
        repo_list.each {|repo| 
          if(@d.is_connected?)
           if(@d.url_exists?(repo.url))
              puts "#{repo.url} already exists...skipping"
            else
              puts "Adding repo to delicious: #{repo.name}"
              @d.add(repo.url, repo.name, repo.description, @gitlish_tag)
              count += 1
            end
          else 
            puts "Not connected. Are you sure your delicious login information is correct?"
          end
        }
      end
        puts "Added #{count} github repos with tag = #{@gitlish_tag}"
    end
  end
end
