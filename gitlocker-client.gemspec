files = Dir['**/*'].select { |f| !f.match /\.gemspec/ }

Gem::Specification.new do |s|
  s.name = %q{gitlocker-client}
  s.version = '0.0.1'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['Alex R. Young']
  s.date = %q{2009-10-31}
  s.description = %q{This is a client library for gitlocker (restful git).}
  s.email = %q{alex@alexyoung.org}
  s.files = files 
  s.has_rdoc = false
  s.homepage = %q{http://github.com/alexyoung/gitlocker-client}
  s.summary = %q{This is a client library for gitlocker which includes a Rails plugin.}
end

