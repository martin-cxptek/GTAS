/*
 *
 *  * All Application code is Copyright 2016, The Department of Homeland Security (DHS), U.S. Customs and Border Protection (CBP).
 *  *
 *  * Please see LICENSE.txt for details.
 *
 */

package gov.gtas.model;

import gov.gtas.enumtype.HitTypeEnum;
import gov.gtas.model.lookup.HitCategory;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "hit_maker")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class HitMaker extends BaseEntity {

	@Column(name = "hit_type", nullable = false)
	@Enumerated(EnumType.STRING)
	protected HitTypeEnum hitTypeEnum;

	@ManyToOne
	@JoinColumn(name = "hit_category", referencedColumnName = "id", columnDefinition = "bigint unsigned")
	private HitCategory hitCategory;

	@OneToMany(mappedBy = "hitMaker", fetch = FetchType.LAZY)
	private Set<HitDetail> hitDetailSet = new HashSet<>();

	public HitCategory getHitCategory() {
		return hitCategory;
	}

	public void setHitCategory(HitCategory hitCategory) {
		this.hitCategory = hitCategory;
	}

	public HitTypeEnum getHitTypeEnum() {
		return hitTypeEnum;
	}

	public void setHitTypeEnum(HitTypeEnum hitTypeEnum) {
		this.hitTypeEnum = hitTypeEnum;
	}

	public Set<HitDetail> getHitDetailSet() {
		return hitDetailSet;
	}

	public void setHitDetailSet(Set<HitDetail> hitDetailSet) {
		this.hitDetailSet = hitDetailSet;
	}
}
