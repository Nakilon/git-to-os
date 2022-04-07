FROM ruby:alpine
COPY --from=rclone/rclone /usr/local/bin/rclone /usr/local/bin/
COPY main.rb /main.rb
CMD sh -c "ruby /main.rb"
