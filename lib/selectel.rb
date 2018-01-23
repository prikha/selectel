require "selectel/version"
require "http"
require "json"

module Selectel
  BASE_URL = 'https://api.selectel.ru/vpc/resell'.freeze

  module V2
    VERSION = 'v2'.freeze

    class Client
      def initialize(token)
        @token = token
      end

      # Projects

      # Get list of projects in current domain.
      # GET /projects
      def projects
        execute(:get, 'projects')
      end

      # Create new project and optionally set quotas on it.
      # POST /projects
      def create_project(props)
        execute(:post, 'projects', json: props)
      end

      # Get full information about Project.
      # GET /projects/{project_id}
      def project(id)
        execute(:get,"projects/#{id}")
      end

      # Update Project's properties.
      # PATCH /projects/{project_id}
      def update_project(id, props)
        execute(:patch, "projects/#{id}", json: props)
      end

      # Delete Project and all it's objects.
      # DELETE /projects/{project_id}
      def delete_project(id)
        execute(:get,"projects/#{id}")
      end

      # Quotas
      #
      # Get total amount of resources available to be allocated to projects.
      #   GET /quotas
      def quotas
        execute(:get, 'quotas')
      end

      # Get amount of resources available to be allocated to projects.
      #   GET /quotas/free
      def quotas_free
        execute(:get, 'quotas/free')
      end

      # Show quotas info for all domain projects.
      #   GET /quotas/projects
      def all_project_quotas
        execute(:get, 'quotas/projects')
      end

      #   GET /quotas/projects/{project_id}
      def project_quotas(project_id)
        execute(:get, "quotas/projects/#{project_id}")
      end

      #   PATCH /quotas/projects/{project_id}
      def update_project_quotas(project_id, opts = {})
        execute(:patch, "quotas/projects/#{project_id}", json: opts)
      end

      # Traffic
      # GET /traffic
      def traffic
        execute(:get, 'traffic')
      end

      # Capabilities
      # Get possible values for different variables
      # GET /capabilities
      def capabilities
        execute(:get, 'capabilities')
      end


      # TODO: wrap following resources

      # Users
      # GET /users
      # POST /users
      # GET /users/{user_id}
      # PATCH /users/{user_id}
      # DELETE /users/{user_id}
      #
      # Roles
      # POST /roles
      # GET /roles/projects/{project_id}/users/{user_id}
      # DELETE /roles/projects/{project_id}/users/{user_id}
      # GET /roles/users/{user_id}
      #
      # Tokens
      # POST /tokens
      #
      # Floating IPs
      # GET /floatingips
      # POST /floatingips/projects/{project_id}
      # GET /floatingips/{floatingip_id}
      # DELETE /floatingips/{floatingip_id}
      #
      # Subnets
      # GET /subnets
      # POST /subnets/projects/{project_id}
      # GET /subnets/{subnet_id}
      # DELETE /subnets/{subnet_id}
      #
      # Licences
      # GET /licenses
      # POST /licenses/projects/{project_id}
      # GET /licenses/{license_id}
      # DELETE /licenses/{license_id}
      #

      private

      def execute(method, path, *args)

        JSON.parse(
          HTTP
            .headers('X-token' => @token)
            .public_send(method, url(path), *args)
        )
      end

      def url(path)
        [BASE_URL, VERSION, path].join('/')
      end
    end
  end
end
