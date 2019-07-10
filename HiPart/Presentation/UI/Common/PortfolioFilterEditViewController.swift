//
//  PortfolioFilterEditViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

protocol FilterChangeDelegate : NSObjectProtocol{
	func filterChanged(filter : Filter?)
}

class PortfolioFilterEditViewController: UIViewController {
	
	@IBOutlet var broadcastStackView1: UIStackView!
	@IBOutlet var broadcastStackView2: UIStackView!
	private var broadcastChips : [FilterChip] = []
	@IBOutlet var pdStackView1: UIStackView!
	private var pdChips : [FilterChip] = []
	@IBOutlet var languageStackView1: UIStackView!
	@IBOutlet var languageStackView2: UIStackView!
	@IBOutlet var langaugeStackView3: UIStackView!
	@IBOutlet var langaugeStackView4: UIStackView!
	private var languageChips : [FilterChip] = []
	@IBOutlet var etcStackView1: UIStackView!
	@IBOutlet var etcStackView2: UIStackView!
	private var etcChips : [FilterChip] = []
	
	
	var selectedFilter : Filter? = nil
	
	@IBOutlet var filterContainer: UIView!
	
	weak var delegate : FilterChangeDelegate? = nil
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
        // Do any additional setup after loading the view.
    }
    
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	@IBAction func tapApplyButton(_ sender: Any) {
		debugE(#function,self.selectedFilter)
		self.delegate?.filterChanged(filter: self.selectedFilter)
		self.hero.dismissViewController()
	}
	
}
extension PortfolioFilterEditViewController {
	private func setupView(){
		let broadcastFilters = Filter.getAllBroadcastFilters()
		let pdFilters = Filter.getAllPdFilters()
		let languageFilters = Filter.getAllLanguageFilters()
		let etcFilters = Filter.getAllEtcFilters()
		
		for i in 0...3{
			let chip = makeFilterChip(filter: broadcastFilters[i])
			
			broadcastStackView1.addArrangedSubview(chip)
		}
		
		for i in 4...6{
			let chip = makeFilterChip(filter: broadcastFilters[i])
			broadcastStackView2.addArrangedSubview(chip)
		}
		for i in 0...1{
			let chip = makeFilterChip(filter: pdFilters[i])
			pdStackView1.addArrangedSubview(chip)
		}
		for i in 0...3{
			let chip = makeFilterChip(filter: languageFilters[i])
			languageStackView1.addArrangedSubview(chip)
		}
		for i in 4...6{
			let chip = makeFilterChip(filter: languageFilters[i])
			languageStackView2.addArrangedSubview(chip)
		}
		for i in 7...9{
			let chip = makeFilterChip(filter: languageFilters[i])
			langaugeStackView3.addArrangedSubview(chip)
		}
		for i in 10...10{
			let chip = makeFilterChip(filter: languageFilters[i])
			langaugeStackView4.addArrangedSubview(chip)
		}
		for i in 0...3{
			let chip = makeFilterChip(filter: etcFilters[i])
			etcStackView1.addArrangedSubview(chip)
		}
		for i in 4...5{
			let chip = makeFilterChip(filter: etcFilters[i])
			etcStackView2.addArrangedSubview(chip)
		}
		
		
		broadcastStackView1.addPaddingView()
		broadcastStackView2.addPaddingView()
		pdStackView1.addPaddingView()
		languageStackView1.addPaddingView()
		languageStackView2.addPaddingView()
		langaugeStackView3.addPaddingView()
		langaugeStackView4.addPaddingView()
		etcStackView1.addPaddingView()
		etcStackView2.addPaddingView()
		
		
		///Filter Set
		if let filter = self.selectedFilter{
			self.tapChip(filter: filter)
		}
		
	}
	
	private func makeFilterChip(filter : Filter) -> FilterChip{
		let chip = FilterChip(frame: .zero, fillMode: false)
		chip.chipSelected = false
		chip.textSizeInspector = 12
		chip.setChipTitle(filter.rawValue)
		chip.filter = filter
		chip.addTarget {[unowned self, filter] in
			self.tapChip(filter: filter)
		}
		switch filter.filterGroup{
		case FilterGroup.BroadcastConcept:
			broadcastChips.append(chip)
		case FilterGroup.PD:
			pdChips.append(chip)
		case FilterGroup.Language:
			languageChips.append(chip)
		case FilterGroup.Etc:
			etcChips.append(chip)
		}
		return chip
	}
	private func tapChip(filter : Filter){
		
		self.selectedFilter = nil
		
		broadcastChips.forEach{chip in
			chip.chipSelected = false
		}
		pdChips.forEach{chip in
			chip.chipSelected = false
		}
		languageChips.forEach{chip in
			chip.chipSelected = false
		}
		etcChips.forEach{chip in
			chip.chipSelected = false
		}
		if let chip = languageChips.first(where: {chip in
			return chip.filter == filter
		}){
			chip.chipSelected = !chip.chipSelected
			
			if chip.chipSelected{
				self.selectedFilter = filter
			}
		}
		if let chip = broadcastChips.first(where: {chip in
			return chip.filter == filter
		}){
			chip.chipSelected = !chip.chipSelected
			
			if chip.chipSelected{
				self.selectedFilter = filter
			}
		}
		
		if let chip = etcChips.first(where: {chip in
			return chip.filter == filter
		}){
			chip.chipSelected = !chip.chipSelected
			
			if chip.chipSelected{
				self.selectedFilter = filter
			}
		}
		
		if let chip = pdChips.first(where: {chip in
			return chip.filter == filter
		}){
			chip.chipSelected = !chip.chipSelected
			
			if chip.chipSelected{
				self.selectedFilter = filter
			}
		}
		
		
	}

	
}
