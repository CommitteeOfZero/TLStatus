namespace :app do
  
  desc "Import (UTF-8) scripts. DELETS ALL EXISTING SCRIPTS! E.g. rake app:import[1,/data/scripts/*.nss]"
  task :import, [:project_id, :glob] => :environment do |task, args|
    @project = Project.find(args.project_id) or raise "Project not found"
    @project.scripts.destroy_all
    Dir[args.glob].each do |entry|
      @project.scripts.create(name: File.basename(entry),
                              stage: "untouched",
                              text: IO.binread(entry))
    end
  end

end
