workspace "finance" {

    !identifiers hierarchical

    model {
        me = person "ME" "Single user and owner of the finance records"
        dev = person "Developer" "The same person as ME, working on Finance"

        finance = softwareSystem "Finance" "Windows desktop application for personal finance, local-first" {
            app = container "Finance desktop application" "The one executable the user runs" ".NET MAUI Blazor Hybrid" {
                desktop = component "Finance.Desktop" "MAUI shell: opens the window, hosts WebView2, wires the other projects" ".NET MAUI"
                ui = component "Finance.UI" "Razor class library with every page and component, and no file access" "Razor"
                domain = component "Finance.Domain" "The finance model and the store interface it needs" ".NET library"
                storage = component "Finance.Storage" "Implements the store interface against JSON files in the data folder" ".NET library"
                adapter = component "Integration adapter" "Anticipated: translates an external API's data into the finance model" ".NET library"
                defaults = component "Finance.ServiceDefaults" "Shared Aspire library that adds OpenTelemetry and health checks" ".NET library"

                desktop -> ui "Hosts and renders"
                desktop -> storage "Composes"
                desktop -> defaults "References"
                ui -> domain "Applies changes through"
                ui -> storage "Saves the affected file through"
                storage -> domain "Implements the store interface of"
                adapter -> domain "Translates into, when built"
            }
            data = container "Data folder" "The JSON files that hold the records, in a folder under the user's OneDrive" "JSON files"
        }

        harness = softwareSystem "Development harness" "The projects and tools that exist only to run and test Finance; nothing here ships" {
            apphost = container "Finance.AppHost" "Aspire entry point that starts Finance and its dashboard" "Aspire"
            dashboard = container "Aspire dashboard" "Shows Finance's logs and traces during development" "Aspire"
            web = container "Finance.Web" "Optional: hosts Finance.UI in a browser over a throwaway data folder" "ASP.NET Core"
            playwright = container "Playwright tests" "End-to-end tests that drive the UI" "Playwright"
        }

        onedrive = softwareSystem "OneDrive" "Microsoft's file service and its Windows client" "External"
        extapi = softwareSystem "External finance API" "Anticipated, not chosen: for example a bank or market-data feed" "External"

        me -> finance "Keeps and reviews their finance records"
        finance -> onedrive "Reads and writes JSON files in a OneDrive folder"
        finance -> extapi "May fetch data later" "not designed"

        me -> finance.app.desktop "Starts Finance"
        me -> finance.app.ui "Edits records"
        finance.app.storage -> finance.data "Reads and writes atomically" "Windows file APIs"
        finance.app.adapter -> extapi "Fetches data from, when built" "HTTPS"
        onedrive -> finance.data "Replicates to the user's other PCs" "OneDrive client"

        dev -> harness.apphost "Starts"
        dev -> harness.playwright "Runs"
        harness.apphost -> finance.app "Launches against a test data folder"
        harness.apphost -> harness.web "Launches, when built"
        harness.web -> finance.app.ui "Hosts, when built"
        harness.web -> finance.app.defaults "References, when built"
        harness.web -> finance.data "Reads and writes a throwaway copy, when built"
        finance.app -> harness.dashboard "Sends logs and traces" "OTLP"
        harness.playwright -> finance.app "Drives the UI through data-testid selectors" "CDP"
        harness.playwright -> harness.web "Drives, when built" "HTTP"

        production = deploymentEnvironment "Production" {
            pca = deploymentNode "Windows PC A" "One of the user's own PCs, with one installation of Finance" "Windows" {
                app = containerInstance finance.app
                data = containerInstance finance.data
                client = infrastructureNode "OneDrive client" "Microsoft's sync client; Finance neither starts nor controls it" "OneDrive"
                client -> data "Syncs"
            }
            cloud = deploymentNode "OneDrive" "Microsoft's cloud storage, in the user's own account" "Microsoft OneDrive" {
                store = infrastructureNode "OneDrive storage" "Holds the replicated copy and its version history" "OneDrive"
            }
            pcb = deploymentNode "Windows PC B" "Optional second PC, with its own installation" "Windows" {
                app = containerInstance finance.app
                data = containerInstance finance.data
                client = infrastructureNode "OneDrive client" "Microsoft's sync client; Finance neither starts nor controls it" "OneDrive"
                client -> data "Syncs"
            }
            pca.client -> cloud.store "Uploads and downloads"
            pcb.client -> cloud.store "Uploads and downloads"
        }

        development = deploymentEnvironment "Development" {
            devpc = deploymentNode "Developer PC" "Runs everything; CI runs the same projects on a Windows runner" "Windows" {
                apphost = containerInstance harness.apphost
                dashboard = containerInstance harness.dashboard
                app = containerInstance finance.app
                web = containerInstance harness.web
                data = containerInstance finance.data "" "Test data folder outside OneDrive"
                playwright = containerInstance harness.playwright
            }
        }
    }

    views {
        systemContext finance business-context {
            title "System Context: Finance"
            include me onedrive extapi
            autolayout lr
        }

        component finance.app level-1 {
            title "Building Blocks: Finance desktop application"
            include me finance.app.desktop finance.app.ui finance.app.domain finance.app.storage finance.app.adapter finance.data extapi
            autolayout tb
        }

        container harness development-harness {
            title "Development Harness"
            include harness.apphost harness.dashboard harness.web harness.playwright finance.app
            autolayout lr
        }

        dynamic finance.app start-and-load "Start and Load" {
            title "Start and Load"
            me -> finance.app.desktop "Starts Finance"
            finance.app.desktop -> finance.app.ui "Asks ME to choose a folder, when none is configured"
            finance.app.desktop -> finance.app.storage "Loads all records"
            finance.app.storage -> finance.data "Reads every JSON file"
            finance.app.desktop -> finance.app.ui "Renders the finance model from memory"
            autolayout lr
        }

        dynamic finance.app save-a-change "Save a Change" {
            title "Save a Change"
            me -> finance.app.ui "Edits a record"
            finance.app.ui -> finance.app.domain "Applies the change, which the model accepts or refuses"
            finance.app.ui -> finance.app.storage "Saves the affected file"
            finance.app.storage -> finance.data "Writes a temporary file, then replaces the original"
            onedrive -> finance.data "Notices the changed file and uploads it in the background"
            autolayout lr
        }

        dynamic * continue-on-another-pc "Continue on Another PC" {
            title "Continue on Another PC"
            me -> finance "Makes changes on PC A, then closes Finance"
            finance -> onedrive "The OneDrive client uploads the changed files"
            onedrive -> finance "The OneDrive client on PC B downloads them"
            me -> finance "Starts Finance on PC B, which loads the current files"
            autolayout lr
        }

        dynamic harness development-run "Development Run with Playwright" {
            title "Development Run with Playwright"
            dev -> harness.apphost "Starts the AppHost"
            harness.apphost -> finance.app "Launches with a test data folder and a WebView2 debugging port"
            finance.app -> harness.dashboard "Sends logs and traces" "OTLP"
            dev -> harness.playwright "Runs the end-to-end tests, then reads results and captures"
            harness.playwright -> finance.app "Connects to WebView2 and drives the UI by data-testid" "CDP"
            autolayout lr
        }

        deployment * "Production" production {
            title "Production"
            include *
            autolayout lr
        }

        deployment * "Development" development {
            title "Development"
            include *
            autolayout lr
        }
    }
}
