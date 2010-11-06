require './gitlish'

if(ARGV.size != 3)
  puts "USAGE: ruby run_gitlish.rb github_username delicious_username, delicious_password"
else
  puts "Publishing your github faves to delicious!"
  @service = Gitlish::Client.new(ARGV[0], ARGV[1], ARGV[2])
  @service.publish_delish(@service.github_retrieve_list())
  puts "Done!"
end



