#
# Cookbook Name:: mail_alias
# Provider:: default
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

action :create do

  newaliases = nil
  begin
    newaliases = run_context.resource_collection.find(:execute => "newaliases")
  rescue
    newaliases = execute "newaliases" do
      action :nothing
    end
  end

  alias_file = nil
  begin
    alias_file = run_context.resource_collection.find(:template => new_resource.alias_file)
  rescue Chef::Exceptions::ResourceNotFound
    alias_file = template new_resource.alias_file do
      action :nothing
      mode "644"
      owner "root"
      group "root"
      source "aliases.erb"
      cookbook "mail_alias"
      variables({:aliases => {}})
      notifies :run, newaliases, :delayed
    end
    new_resource.notifies(:create, alias_file, :delayed)
    new_resource.notifies(:run, newaliases, :delayed)
  end
 
  if not alias_file.variables[:aliases].has_key?(new_resource.name)
    alias_file.variables[:aliases][new_resource.name] = []
  end

  if new_resource.recipients.is_a? String
      alias_file.variables[:aliases][new_resource.name] << new_resource.recipients
  elsif new_resource.recipients.is_a? Array
      alias_file.variables[:aliases][new_resource.name].concat new_resource.recipients
  end
  
  new_resource.updated_by_last_action(true)
end
