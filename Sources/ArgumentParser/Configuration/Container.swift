//
//  Container.swift
//  ArgumentParser
//
//  Created by Botond Magyarosi on 01/07/2018.
//

import Foundation

internal protocol Container {
    var commands: [Command] { get set }
    var parameters: [Parameter]  { get set }
    var options: [Option] { get set }
}
