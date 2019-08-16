//
//  JSRuntimeFile.swift
//  plank
//
//  Created by Michael Schneider
//
//

import Foundation

/* Runtime file with helper types */
struct JSRuntimeFile: FileGenerator {
    static func runtimeImports() -> String {
        return JSIR.fileImportStmt("PlankDate, PlankURI", "runtime.flow")
    }

    var fileName: String {
        return "runtime.flow.js"
    }

    var indent: Int {
        return 2
    }

    func renderContent() -> String {
        return [
            "export type $Object<V> = { +[key: string]: V }",
            "export type _$Values<V, O: $Object<V>> = V",
            "export type $Values<O: Object> = _$Values<*, O>",
            "export type PlankDate = string",
            "export type PlankURI = string",
        ].map { $0 + ";" }
            .joined(separator: "\n")
    }

    func renderFile() -> String {
        let output = (
            [self.renderCommentHeader()] + [self.renderContent()]
        )
        .map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
        .filter { $0 != "" }
        .joined(separator: "\n\n")
        return output
    }
}

extension JSRuntimeFile {
    func renderCommentHeader() -> String {
        let header = [
            "//  @flow",
            "//",
            "//  \(self.fileName)",
            "//  Autogenerated by Plank (https://pinterest.github.io/plank/)",
            "//",
            "//  DO NOT EDIT - EDITS WILL BE OVERWRITTEN",
            "//  @generated",
            "//",
        ]

        return header.joined(separator: "\n")
    }
}
