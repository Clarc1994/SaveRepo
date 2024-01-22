//
//  Constans.swift
//  SaveRepo
//
//  Created by A1398 on 16/01/2023.
//

import Foundation

struct K {
    
    struct ApiErrors {
        static let dataDownloadError = "Blad pobierania danych"
        static let noDataError = "Brak danych"
        static let dataParsingError = "Błąd parsowania danych"
    }
    struct Cell {
        static let CellRepozytoryNibName = "CellListOfRepository"
        static let CellRepozytoryIdentifier = "CellRepozytoryIdentifier"
        static let CellSimpleNibName = "CellSimple"
        static let CellSimpleIdentifier = "CellSimpleIdentifier"
    }
    struct TextAlert {
        static let dataSaveError = "Błąd zapisu danych"
        static let dataHandlingError = "Błąd obsługi danych"
        static let dataDeleteError = "Bład usuwania danych"
        static let deleteSucces = "Usunięto"
    }
    struct DataBaseNameClass {
        static let nameItemDataBaseMO = "ItemDataBaseMO"
    }
}
