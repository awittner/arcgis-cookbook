#
# Cookbook Name:: esri-iis
# Recipe:: install
#
# Copyright 2021 Esri
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
#

node['arcgis']['iis']['features'].each do |feature|
  windows_feature feature do
    timeout 1200
    retries 2
    retry_delay 60
    action :install
  end
end

service 'W3SVC' do
  action [:enable, :start]
end
