#!/usr/bin/env rake
require 'rake/testtask'
require 'rubocop/rake_task'
require 'foodcritic'

Rake::TestTask.new do |t|
  t.libs.push 'lib'
  t.test_files = FileList['test/**/*_spec.rb']
  t.verbose = true
end

desc 'Setup and run Foodcritic'
task :foodcritic do
  Rake::Task['foodcritic:setup'].invoke
  Rake::Task['foodcritic:run'].invoke
end

namespace :foodcritic do
  task :setup do
    sandbox = File.join(File.dirname(__FILE__), %w(tmp foodcritic cookbook))
    prepare_foodcritic_sandbox(sandbox)
  end

  FoodCritic::Rake::LintTask.new(:run) do |t|
    t.options = {
      tags: %w(
        ~solo
        ~FC019
      ),
      fail_tags: ['any'],
      cookbook_paths: File.join(File.dirname(__FILE__), %w(tmp foodcritic cookbook))
    }
  end
end

desc 'RuboCop compliancy checks'
RuboCop::RakeTask.new(:rubocop)

private

def prepare_foodcritic_sandbox(sandbox)
  files = %w(*.md *.rb attributes definitions files providers recipes resources templates)

  rm_rf sandbox
  mkdir_p sandbox
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox
end

task default: [:rubocop, :foodcritic, :test]
