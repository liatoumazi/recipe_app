//
//  run_recipe_retrival.swift
//  ui
//
//  Created by Lia Toumazi on 06/02/2023.
//

import Foundation
import PythonKit

func run_recipe_retrival() -> PythonObject {
    let sys = Python.import("sys")
    sys.path.append("/Users/liatoumazi/Documents/CODE/GitHub/recipe_app/ui/ui/")
    let file = Python.import("recipe_retrival")
    
    let response = file.get_recipes()
    print(response)
    return response
}
