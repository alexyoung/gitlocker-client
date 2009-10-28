unless Kernel.const_defined? :Gitlocker
  require File.join(File.dirname(File.expand_path(__FILE__)), 'init')
end

module Gitlocker::Rails
  def self.install
    ActiveRecord::Base.extend Gitlocker::Rails::Install
  end

  module Install
    def self.extended(base)
      base.extend Gitlocker::Rails::ClassMethods
      base.class_eval do
        class_inheritable_accessor :gitlocker_site
        class_inheritable_accessor :gitlocker_field_names
        class_inheritable_accessor :gitlocker_repo
      end
    end
  end

  module InstanceMethods
    def gitlocker_repo_id
      gitlocker_repo.kind_of?(Proc) ? gitlocker_repo.call(self) : gitlocker_repo
    end

    def gitlocker_id(name)
      "#{read_attribute(self.class.primary_key)}_#{name}"
    end

    def gitlocker_fields
      gitlocker_field_names.map { |name| [name, gitlocker_id(name)] }
    end

    def gitlocker_create
      gitlocker_fields.each do |name, gl_document|
        Gitlocker::Document.create gitlocker_site, {
          :repo_id => gitlocker_repo_id,
          :document => {
            :id => gl_document,
            :data => read_attribute(name)
          }
        }
      end
    end

    def gitlocker_update
      gitlocker_fields.each do |name, gl_document|
        Gitlocker::Document.update gitlocker_site, {
          :repo_id => gitlocker_repo_id,
          :document => {
            :id => gl_document,
            :data => read_attribute(name)
          }
        }
      end
    end

    def gitlocker_destroy
      gitlocker_fields.each do |name, gl_document|
        Gitlocker::Document.destroy gitlocker_site, {
          :repo_id => gitlocker_repo_id,
          :id => gl_document 
        }
      end
    end

    def gitlocker_version(field_name, version)
      Gitlocker::Document.version gitlocker_site, {
        :repo_id => gitlocker_repo_id,
        :id => gitlocker_id(field_name),
        :version => version
      }
    end

    def gitlocker_versions(field_name)
      Gitlocker::Document.versions gitlocker_site, {
        :repo_id => gitlocker_repo_id,
        :id => gitlocker_id(field_name)
      }
    end
  end

  module ClassMethods
    def gitlocker(site, options = {})
      include Gitlocker::Rails::InstanceMethods

      self.gitlocker_site = site
      self.gitlocker_field_names = options[:fields].kind_of?(Array) ? options[:fields] : [options[:fields]]
      self.gitlocker_repo = options[:repo_id]

      after_create :gitlocker_create
      after_update :gitlocker_update
      after_destroy :gitlocker_destroy
    end
  end
end

Gitlocker::Rails.install
