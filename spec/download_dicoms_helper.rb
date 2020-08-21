# frozen_string_literal: true

require 'fileutils'

def download_dicoms
  zip = 'spec/support/FluoroWithDisplayShutter.dcm.zip'
  return true if File.exist?(zip)

  zip_url = 'http://www.dclunie.com/images/FluoroWithDisplayShutter.dcm.zip'
  support_dir = 'spec/support/dicoms'
  system("curl #{zip_url} --output #{zip}")
  FileUtils.mkdir_p support_dir
  system("unzip #{zip} -d #{support_dir}")
end
