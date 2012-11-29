require 'capistrano/recipes/deploy/strategy/remote'

module Capistrano
  module Deploy
    module Strategy

      class HgRemoteCache < RemoteCache

        private

        def copy_repository_cache
          logger.trace "copying the cached version to #{configuration[:release_path]}"
          if copy_exclude.empty?
            run "cd #{repository_cache} && hg update --rev #{branch} #{configuration[:release_path]} && #{mark}"
          else
            exclusions = copy_exclude.map { |e| "--exclude=\"#{e}\"" }.join(' ')
            run "rsync -lrpt #{exclusions} #{repository_cache}/ #{configuration[:release_path]} && #{mark}"
          end
        end
      end

    end
  end
end
