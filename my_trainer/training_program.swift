//
//  training_program.swift
//  my_trainer
//
//  Created by  Kirill Berezin on 06.04.2020.
//  Copyright © 2020  Kirill Berezin. All rights reserved.
//

import Foundation

class trainingProgram {
    var exersises: Array<exersise>;
    var current_exersise = 0;
    
    init() {
        current_exersise = -1;
        exersises = Array<exersise>();
        defaultProgram();
    }
    
    private func defaultProgram() -> Void {
        exersises.append(exersise(name: "Jumping jacks", duration: 30, rest: 15))
        exersises.append(exersise(name: "Wall sit", duration: 30, rest: 15))
        exersises.append(exersise(name: "Push-up", duration: 30, rest: 15))
        exersises.append(exersise(name: "Abdominal crunch", duration: 30, rest: 15))
        exersises.append(exersise(name: "Step-up", duration: 30, rest: 15))
        exersises.append(exersise(name: "Squat", duration: 30, rest: 15))
        exersises.append(exersise(name: "Tripses dip", duration: 30, rest: 15))
        exersises.append(exersise(name: "Plank", duration: 30, rest: 15))
        exersises.append(exersise(name: "High knees running", duration: 30, rest: 15))
        exersises.append(exersise(name: "Lunge", duration: 30, rest: 15))
        exersises.append(exersise(name: "Push-Up and rotation", duration: 30, rest: 15))
        exersises.append(exersise(name: "Side plank", duration: 30, rest: 15))
        
        //exersises.append(exersise(name: "Plank", duration: 10, rest: 5))
        //exersises.append(exersise(name: "Side plank", duration: 10, rest: 5))

    }
    
    public func start() -> Void {
        current_exersise = 0
    }
    
    public func next() -> Optional<exersise> {
        if current_exersise < exersises.count && !exersises.isEmpty {
            let act = exersises[current_exersise]
            current_exersise += 1
            return act
        }
        return nil
    }
}
