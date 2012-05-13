namespace :git do

  desc "prune"
  task :prune do
    # Prepare origin and ensure on master to do comparison
    print "\nFetch and prune tracking branches? [y/N] "
    yes_no = $stdin.gets.chomp
    abort if yes_no.downcase != 'y'
    system('git fetch && git remote prune origin')
    abort "Must be on master to find already merged branches." if current_branch != 'master'

    # Offer to delete remote branches that are already in (local) master
    out = run_cmd("git branch -r --merged")
    branches = out.split("\n").reject { |b| b =~ /(production|release|staging|master)$/i || b !~ /^\s*origin/i }
    if branches.empty?
      puts "No remote branches to prune."
    else
      puts "\nThe following remote branches are fully contained in HEAD of #{current_branch}:"
      puts branches
      print "\nDelete from origin? (GitHub) [y/N] "
      yes_no = $stdin.gets.chomp
      abort if yes_no.downcase != 'y'

      branches.map! { |b| b.sub(/^\s*origin\//i, '') }  # remove origin/
      system("git push origin --delete #{branches.join(' ')} && git remote prune origin") # delete stuff!
    end

    # Local branches that could be deleted
    out = run_cmd("git branch --merged")
    branches = out.split("\n").reject { |b| b =~ /(production|release|staging|master)$/i }
    unless branches.empty?
      puts "\nThe following local branches are fully contained in HEAD of #{current_branch}:"
      puts branches
      puts "\nLocal pruning is left as an exercise for the reader."
    end
  end

  # local branch currently checked out:
  def current_branch
    out = run_cmd('git branch')
    local_branch = $1 if out =~ /\* (\S+)\s/m
  end

  def run_cmd(cmd)
    out = `#{cmd}`
    err = $?
    raise "Running `#{cmd}' failed (#{err})." unless err == 0
    out
  end

end