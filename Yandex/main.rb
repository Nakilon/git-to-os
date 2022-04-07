Dir[?*].each do |bucket|
  next unless File.directory? bucket
  ENV.store "AWS_ACCESS_KEY_ID", ENV.delete("INPUT_AWS_ACCESS_KEY_ID")
  ENV.store "AWS_SECRET_ACCESS_KEY", ENV.delete("INPUT_AWS_SECRET_ACCESS_KEY")
  `rclone -v --auto-confirm sync #{bucket} :s3,provider=Other,endpoint=storage.yandexcloud.net,env_auth:#{bucket}`
end
