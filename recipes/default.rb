#
# Cookbook Name:: aliases
# Recipe:: default
# Author:: Mathieu Sauve-Frankel <msf@kisoku.net>
#
# Copyright 2012, Mathieu Sauve-Frankel, <msf@kisoku.net>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

execute "newaliases" do
  action :nothing
end

template node[:mail_alias][:alias_file] do
  action :nothing
  mode "644"
  owner "root"
  group "root"
  source "aliases.erb"
  cookbook "mail_alias"
  variables({:aliases => {}})
  notifies :run, newaliases
end

accumulator "collect mail_aliases for #{node[:mail_alias][:alias_file]}"  do
  target "template[#{node[:mail_alias][:alias_file]}"

  filter do |resource|
    resource.is_a? Chef::Resource::MailAlias
  end

  transform do |resources|
    aliases = {}
    resources.each do |res|
      aliases[res.name] = aliases unless aliases.has_key?(res.name)
    end
    resources
  end

  variable :aliases
end
