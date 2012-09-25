#!/usr/bin/env ruby

require 'erb'
require 'fileutils'

base_path    = File.expand_path('../..', __FILE__)
repos_path   = File.join(base_path, 'repos')
scripts_path = File.join(base_path, 'scripts')
etc_path     = File.join(base_path, 'etc')
html_path    = File.join(base_path, 'html')

repos = %w!
  paperboy-all/all.wiki
  paperboy-sqale/sqale-app.wiki
  paperboy-sqale/sqale-chef.wiki
  paperboy-sqale/sqale-nagios.wiki
  paperboy-sqale/sqale-proxy.wiki
  paperboy-sqale/sqale-puppet.wiki
  paperboy-puboo/puboo-app.wiki
  paperboy-heteml/heteml-ops.wiki
  paperboy-heteml/heteml-dev.wiki
  paperboy-jugemcart/jugemcart-admin.wiki
  paperboy-jugemcart/jugemcart-puppet.wiki
!

unless Dir.exists?(repos_path)
  Dir.mkdir(repos_path)
end

unless Dir.exists?(html_path)
  Dir.mkdir(html_path)
end

port = 5000

repos.each do |repo|
  repo_dir = File.join(repos_path, repo.sub('/', '-'))
  unless Dir.exists?(repo_dir)
    `hub clone -p #{repo} #{repo_dir}`
  end

  File.write(
    File.join(etc_path, repo.sub('/', '-') + '.ini'),
    ERB.new(
      File.read(File.join(base_path, 'templates', 'supervisord.erb'))
    ).result(binding)
  )

  start_script_file = File.join(scripts_path, repo.sub('/', '-') + '.sh')
  File.write(
    start_script_file,
    ERB.new(
      File.read(File.join(base_path, 'templates', 'start.erb'))
    ).result(binding)
  )

  FileUtils.chmod(0755, start_script_file)

  port += 1
end

File.write(
  File.join(html_path, 'index.html'),
  ERB.new(
    File.read(File.join(base_path, 'templates', 'index.erb'))
  ).result(binding)
)

File.write(
  File.join(scripts_path, 'pull.sh'),
  ERB.new(
    File.read(File.join(base_path, 'templates', 'pull.erb'))
  ).result(binding)
)

FileUtils.chmod(0755, File.join(scripts_path, 'pull.sh'))
