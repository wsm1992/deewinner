FROM ruby:2.4.3
WORKDIR /work

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files 
# are made.
COPY Gemfile /work 
COPY Gemfile.lock /work 
COPY process.rb /work 
COPY lib /work/lib
RUN mkdir -p /work/output
RUN gem install bundler && bundle install --jobs 20 --retry 5


# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
CMD ["bash"]
