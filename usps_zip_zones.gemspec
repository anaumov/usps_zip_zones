lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "usps_zip_zones"
  spec.version       = '0.0.1'
  spec.authors       = ["Alexey Naumov"]
  spec.email         = ["alexsnaumov@gmail.com"]

  spec.summary       = %q{Ruby implementation for usps zone calculator}
  spec.description   = %q{Find zone by origin and destination zip codes.}
  spec.homepage      = "https://github.com/anaumov/usps_zip_zones"
  spec.license       = "MIT"

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.0"
end
