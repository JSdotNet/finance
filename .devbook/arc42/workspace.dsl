workspace "finance" {

    !identifiers hierarchical

    model {
        me = person "ME" "Single user and owner of the finance records"
        finance = softwareSystem "Finance" "Windows desktop application for personal finance, local-first"
        onedrive = softwareSystem "OneDrive" "Microsoft's file service and its Windows client" "External"
        extapi = softwareSystem "External finance API" "Anticipated, not chosen: for example a bank or market-data feed" "External"

        me -> finance "Keeps and reviews their finance records"
        finance -> onedrive "Reads and writes JSON files in a OneDrive folder"
        finance -> extapi "May fetch data later" "not designed"
    }

    views {
        systemContext finance business-context {
            title "System Context: Finance"
            include me onedrive extapi
            autolayout lr
        }
    }
}
