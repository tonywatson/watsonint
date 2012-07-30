# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Watsonint::Application.initialize!

ENV['S3_BUCKET'] = 'watsonint'
ENV['S3_KEY'] = 'AKIAI6JJRPLQXFICOCWQ'
ENV['S3_SECRET'] = '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'