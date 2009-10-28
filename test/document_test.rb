require 'test_helper'

site = 'http://localhost:4567'
repo_id = 'unit_tests'

puts "These tests are not mocked, they're running against: #{site}"

context 'Document' do
  asserts_response_ok 'create document' do
    Gitlocker::Document.create(site, { :repo_id => repo_id, :document => { :id => 1, :data => 'test' } })
  end

  asserts_response_ok 'update document' do
    Gitlocker::Document.update(site, { :repo_id => repo_id, :document => { :id => 1, :data => 'test 2!' } })
  end

  asserts 'newest version is the expected value' do
    Gitlocker::Document.find(site, { :repo_id => repo_id, :id => 1 })
  end.equals('test 2!')

  asserts 'first version is the expected value' do
    Gitlocker::Document.version(site, { :repo_id => repo_id, :id => 1, :version => 0 })
  end.equals('test')

  asserts_response_ok 'repo is deleted' do
    Gitlocker::Repository.destroy site, { :repo_id => repo_id }
  end
end
