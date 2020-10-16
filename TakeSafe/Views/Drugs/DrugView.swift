//
//  DrugView.swift
//  TakeSafe
//
//  Created by Linus Långberg on 2020-10-06.
//

import SwiftUI
import BetterSafariView

struct DrugView: View {
    var drug: Drug
    
    @State var showLearnMore = false
    @State var showDrugClassAlert = false
    @State var showDependenceAlert = false
    @State var showAddictionAlert = false
    @State var showTakeDrugView = false
    
    var body: some View {
        Form {
            Section() {
                Button(action: {
                    showLearnMore = true
                }, label: {
                    HStack {
                        Text(drug.description)
                            .padding(.trailing)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                })
                .padding(.vertical)
                .foregroundColor(.primary)
                
                HStack {
                    Text("Drug class")
                        .bold()
                    
                    Spacer()
                    
                    Text(drug.drugClass.rawValue)
                    
                    Button(action: {
                        showDrugClassAlert = true
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                    .alert(isPresented: $showDrugClassAlert) {
                        Alert(title: Text("Stimulant"), message: Text("A substance that raises levels of physiological or nervous activity in the body."), dismissButton: .default(Text("OK")))
                    }
                }
                .padding(.vertical, 7.5)
                
                HStack {
                    Text("Dependence")
                        .bold()
                    
                    Spacer()
                    
                    Text(drug.dependence.rawValue)
                    
                    Button(action: {
                        showDependenceAlert = true
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                    .alert(isPresented: $showDependenceAlert) {
                        Alert(title: Text("Dependence"), message: Text("Dependence is an adaptive state that develops from repeated drug administration and results in withdrawal upon cessation of drug use."), dismissButton: .default(Text("OK")))
                    }
                }
                .padding(.vertical, 7.5)
                
                HStack {
                    Text("Addiction")
                        .bold()
                    
                    Spacer()
                    
                    Text(drug.addiction.rawValue)
                    
                    Button(action: {
                        showAddictionAlert = true
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                    .alert(isPresented: $showAddictionAlert) {
                        Alert(title: Text("Addiction"), message: Text("Addiction is a brain disorder characterized by compulsive engagement in rewarding stimuli despite adverse consequences."), dismissButton: .default(Text("OK")))
                    }
                }
                .padding(.vertical, 7.5)
                
                Timeline(onset: drug.onset, duration: drug.duration)
                    .padding(.vertical)
            }
            
            Section() {
                Button("Take \(drug.name)") {
                    showTakeDrugView = true
                }
            }
        }
        .navigationBarTitle(drug.name)
        .safariView(isPresented: $showLearnMore) {
            SafariView(url: drug.learnMoreUrl, configuration: SafariView.Configuration(
                entersReaderIfAvailable: true
            ))
        }
        .sheet(isPresented: $showTakeDrugView) {
            TakeDrugView(drug: drug, presented: $showTakeDrugView)
        }
    }
}
