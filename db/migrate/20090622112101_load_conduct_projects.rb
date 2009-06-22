class LoadConductProjects < ActiveRecord::Migration
  def self.up

       #From existing app: select c.name, p.name as parent_name from timeflux_project as c, timeflux_project as p where c.parent_id = p.id and p."parent_id" IS NULL
    projects = '"AMA Low Cost","Norwegian Air Shuttle"
"BIP","Oslo Børs"
"Sesam katalog","Schibsted"
"BONO / Drift, Forvaltning og support","Norwegian Air Shuttle"
"Bagasjegebyr","Norwegian Air Shuttle"
"Ny faring","Norwegian Air Shuttle"
"AMA LCC fase 3","Norwegian Air Shuttle"
"Support og konsulenttjenester","Selvaag Bluethink"
"Finnair-samarbeid","Norwegian Air Shuttle"
"FlyNordic integrasjon","Norwegian Air Shuttle"
"Billettløse grupper","Norwegian Air Shuttle"
"Manka","Opplysningen"
"Clustering Workshop","Otrum"
"Zett","Zett"
"Confluence","Aspiro"
"Rådgivning","NSB"
"Oppgaveportalen","Avinor"
"Internt","Conduct"
"Konsulentbistand","FLO/IKT (Forsvaret)"
"Confluence","Aspiro"
"Confluence","Aspiro"
"AMP","Aspiro"
"Otto","NLS"
"Folk.no","Aspiro"
"Nummeropplysning","Aspiro"
"Rampe","Statens Pensjonskasse"
"Atlassian","Aspiro"
"Support","Fara"
"Salgsklient","Sparebank 1 Skadeforsikring"
"PULS","Aftenposten"
"Multimedia","Aftenposten"
"NewCore","Hurtigruten ASA"
"Kasseautomat","Tomra"
"Mørk Fiber","Hafslund Telekom"
"Atlassian","Aspiro"
"Simulering","Tomra"
"Konsulentbistand","TraceTracker"
"Kurs/Workshop","USIT"
"RedHat Health Check","Tollpost"
"Forprosjekt Oppgaveportalen","Avinor"
"Forprosjekt Migrering av Lisa","NSB"
"RedHat Enterprise Engineer","Tollpost"
"Strategisk partner","Tollpost"
"Migrering av Lisa","NSB"
"PCI","Carrot"
"Millionær","TV2"
"Fravær","Conduct"
"Stillingsannonser","NSB"
"Konsulenttjenester","Carrot"
"SSO","TV2"
"BI CRM","Expert"
"Provisioning","NSB"
"Bouvet","Umoe Consulting"
"Bouvet","Umoe Consulting"
"Infrastruktur","A-pressen"
"Konsulentbistand","ABMU"
"SMS søk på nesten alt (UZ1010)","Opplysningen"
"Rådgivning","Nordpool"
"Spaceman","NMD"
"Farmalink","NMD"
"Felles avregning","Norgesgruppen Data AS"
"Grunndata","Norgesgruppen Data AS"
"Leverandørportal","Norgesgruppen Data AS"
"Prosess og verktøy","Norgesgruppen Data AS"
"TOS","Norgesgruppen Data AS"
"223PMSFO","Ergo"
"JBoss","FOSS community"
"EDGE","NetTicket"
"Generell bistand","FileFlow"
"Konsulentbistand","Boostcom"
"PLUSS","Mercer HR"
"Logistikk Online 52120088","Ergo"
"Reaktor","Deichman"
"NKH","Nasjonalt Kompetansesenter for Helsetjenester"
"Workshop","Mobiletech"
"Pentaho","FOSS community"
"Konsulentbistand","Community Reborn"
"Protectorial","Message Management"
"Sesam Søk","Aspiro"
"Jboss Migrering","Corporate Express Nordic AS"
"Flexistamp","Flexistamp"
"Drift Oppsett","Corporate Express Nordic AS"
"Vis vei","Geodata AS"
"POC","Agder Energi"
"Løpende timer","EDB"
"Sesam","Schibsted"
"Konsulentbistand JBoss","Politiet"
"Forskningsprosjekt","Simula"
"Migrering fra Weblogic","Skagerak"'


    projects.split("\n").each  do |name|
      entry = name.split(",")
      name = entry[0].gsub(/"/, '')
      parent = entry[1].gsub(/"/, '')

      c = Category.create( :name => "#{parent} > #{name}" )
      if c.id
        Activity.create(:name=> "Utvikling", :description => "General development", :default_activity => false, :active => true, :category_id => c.id )
      end
    end



  end

  def self.down
    
  end
end
