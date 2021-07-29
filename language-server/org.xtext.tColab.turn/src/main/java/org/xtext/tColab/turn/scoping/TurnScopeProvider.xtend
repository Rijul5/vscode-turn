/*
 * generated by Xtext 2.22.0
 */
package org.xtext.tColab.turn.scoping

import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.xtext.naming.QualifiedName
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.Scopes
import org.xtext.tColab.turn.turn.Actor
import org.xtext.tColab.turn.turn.AndJoin
import org.xtext.tColab.turn.turn.ComponentRef
import org.xtext.tColab.turn.turn.EndPoint
import org.xtext.tColab.turn.turn.FailurePoint
import org.xtext.tColab.turn.turn.IntentionalElement
import org.xtext.tColab.turn.turn.OrJoin
import org.xtext.tColab.turn.turn.Path
import org.xtext.tColab.turn.turn.PluginBinding
import org.xtext.tColab.turn.turn.RespRef
import org.xtext.tColab.turn.turn.StartPoint
import org.xtext.tColab.turn.turn.Stub
import org.xtext.tColab.turn.turn.Timer
import org.xtext.tColab.turn.turn.TurnPackage
import org.xtext.tColab.turn.turn.UCMmap
import org.xtext.tColab.turn.turn.URNspec
import org.xtext.tColab.turn.turn.WaitingPlace

/**
 * This class contains custom scoping description.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#scoping
 * on how and when to use it.
 */
class TurnScopeProvider extends AbstractTurnScopeProvider {

		  override getScope(EObject context, EReference reference) {
		  	
			val rootMap = EcoreUtil2.getContainerOfType(context, UCMmap)
			if(rootMap !== null){
				
				val endPoints = EcoreUtil2.getAllContentsOfType(rootMap, EndPoint)
				val resps = EcoreUtil2.getAllContentsOfType(rootMap, RespRef)
				val components = EcoreUtil2.getAllContentsOfType(rootMap, ComponentRef)
				val startPoints = EcoreUtil2.getAllContentsOfType(rootMap, StartPoint)
				val stubs = EcoreUtil2.getAllContentsOfType(rootMap, Stub)
				val rootStub = EcoreUtil2.getContainerOfType(context, PluginBinding)

				if(rootStub !== null){
					if (reference == TurnPackage.eINSTANCE.outBinding_MapEnd) {
						val pbs1 = EcoreUtil2.getAllReferencedObjects(rootStub, TurnPackage.eINSTANCE.pluginBinding_Map);
						val eps1 = EcoreUtil2.getAllContentsOfType(pbs1.get(0), EndPoint);
					return Scopes.scopeFor(eps1, [EndPoint e|
						return QualifiedName.create(e.name)
					],  IScope.NULLSCOPE)
					}
					
					if (reference == TurnPackage.eINSTANCE.inBinding_MapStart) {
						val pbs1 = EcoreUtil2.getAllReferencedObjects(rootStub, TurnPackage.eINSTANCE.pluginBinding_Map);
						val sps1 = EcoreUtil2.getAllContentsOfType(pbs1.get(0), StartPoint);
					return Scopes.scopeFor(sps1, [StartPoint e|
						return QualifiedName.create(e.name)
					], IScope.NULLSCOPE)
				
				}
					}
					
				if (reference == TurnPackage.eINSTANCE.boundElement_Elem) {
					return Scopes.scopeFor(startPoints, [StartPoint e|
						return QualifiedName.create(e.name)
					], Scopes.scopeFor(resps, [RespRef e|
						return QualifiedName.create(e.name)
					], Scopes.scopeFor(components, [ComponentRef e|
						return QualifiedName.create(e.name)
					], Scopes.scopeFor(stubs, [Stub e|
						return QualifiedName.create(e.name)
					], Scopes.scopeFor(endPoints, [EndPoint e|
						return QualifiedName.create(e.name)],IScope.NULLSCOPE)))))
				}
				
				if (reference == TurnPackage.eINSTANCE.pathBody_ReferencedEnd ) {
					val cPath = EcoreUtil2.getContainerOfType(context, Path)	
					val map = EcoreUtil2.getContainerOfType(context, UCMmap)
					val allOrJoins = EcoreUtil2.getAllContentsOfType(map, OrJoin)
					val andJoins = EcoreUtil2.getAllContentsOfType(map, AndJoin)
					val timers = EcoreUtil2.getAllContentsOfType(map, Timer)
					val failurePoints = EcoreUtil2.getAllContentsOfType(map, FailurePoint)
					return Scopes.scopeFor(allOrJoins, [
						j |
						val jsPath = EcoreUtil2.getContainerOfType(j, Path)			
						val jsMap = EcoreUtil2.getContainerOfType(j, UCMmap)		
						if (jsPath === cPath || jsMap == map) {
							return QualifiedName.create(j.name)
						}
						return QualifiedName.create(map.name).append(QualifiedName.create(j.name))
					],Scopes.scopeFor(resps, [r |
						val rsPath = EcoreUtil2.getContainerOfType(r, Path)
						val rsMap = EcoreUtil2.getContainerOfType(r, UCMmap)					
						if (rsPath === cPath || rsMap == map) {
							return QualifiedName.create(r.name)
						}
						return QualifiedName.create(map.name).append(QualifiedName.create(r.name))
					],Scopes.scopeFor(andJoins, [aj |
						val jsPath = EcoreUtil2.getContainerOfType(aj, Path)
						val jsMap = EcoreUtil2.getContainerOfType(aj, UCMmap)					
						if (jsPath === cPath || jsMap == map) {
							return QualifiedName.create(aj.name)
						}
						return QualifiedName.create(map.name).append(QualifiedName.create(aj.name))
					],Scopes.scopeFor(timers, [t |
						val tsPath = EcoreUtil2.getContainerOfType(t, Path)
						val tsMap = EcoreUtil2.getContainerOfType(t, UCMmap)					
						if ((tsPath === cPath || tsMap == map) && (t.name !== null)) {
							return QualifiedName.create(t.name)
						}
						if(t.name !== null)
							return QualifiedName.create(map.name).append(QualifiedName.create(t.name))
					],Scopes.scopeFor(failurePoints, [fps |
						val fpsPath = EcoreUtil2.getContainerOfType(fps, Path)
						val fpsMap = EcoreUtil2.getContainerOfType(fps, UCMmap)					
						if ((fpsPath === cPath || fpsMap == map) && fps.name !== null) {
							return QualifiedName.create(fps.name)
						}
						if(fps.name !== null)
							return QualifiedName.create(map.name).append(QualifiedName.create(fps.name))
					], IScope.NULLSCOPE)))))
				} 
				
				if (reference == TurnPackage.eINSTANCE.connect_ConnectsTo ) {
					val cPath = EcoreUtil2.getContainerOfType(context, Path)	
					val map = EcoreUtil2.getContainerOfType(context, UCMmap)
					val startPts = EcoreUtil2.getAllContentsOfType(map, StartPoint)
					val wps = EcoreUtil2.getAllContentsOfType(map, WaitingPlace)
					val timers = EcoreUtil2.getAllContentsOfType(map, Timer)
					
					return Scopes.scopeFor(startPts, [
						sp |
						val spPath = EcoreUtil2.getContainerOfType(sp, Path)			
						val spMap = EcoreUtil2.getContainerOfType(sp, UCMmap)		
						if (spPath === cPath || spMap == map) {
							return QualifiedName.create(sp.name)
						}
						return QualifiedName.create(map.name).append(QualifiedName.create(sp.name))
						],Scopes.scopeFor(wps, [
						wp |
						val wpPath = EcoreUtil2.getContainerOfType(wp, Path)			
						val wpMap = EcoreUtil2.getContainerOfType(wp, UCMmap)		
						if (wpPath === cPath || wpMap == map) {
							if(wp.name !== null)
								return QualifiedName.create(wp.name)
						}
						if(wp.name !== null)
							return QualifiedName.create(map.name).append(QualifiedName.create(wp.name))
						],Scopes.scopeFor(timers, [
						t |
						val tsPath = EcoreUtil2.getContainerOfType(t, Path)			
						val tsMap = EcoreUtil2.getContainerOfType(t, UCMmap)		
						if ((tsPath === cPath || tsMap == map) && (t.name !== null)) {
							return QualifiedName.create(t.name)
						}
						if(t.name !== null)
							return QualifiedName.create(map.name).append(QualifiedName.create(t.name))
						],	IScope.NULLSCOPE)))
					}
				
				
				if (reference == TurnPackage.eINSTANCE.pathBody_ReferencedStub ) {
					val cPath = EcoreUtil2.getContainerOfType(context, Path)	
					val map = EcoreUtil2.getContainerOfType(context, UCMmap)
					val refstubs = EcoreUtil2.getAllContentsOfType(map, Stub)
					
					return Scopes.scopeFor(refstubs, [
						s |
						val sPath = EcoreUtil2.getContainerOfType(s, Path)			
						val sMap = EcoreUtil2.getContainerOfType(s, UCMmap)		
						if ((sPath === cPath || sMap == map) && (s.name !== null)) {
							return QualifiedName.create(s.name)
						}
						if(s.name !== null)
							return QualifiedName.create(map.name).append(QualifiedName.create(s.name))
						],IScope.NULLSCOPE)
				}
			
		}
		
		if(reference === TurnPackage.eINSTANCE.contribution_Dest || reference === TurnPackage.eINSTANCE.decomposition_Dest || reference === TurnPackage.eINSTANCE.dependency_Dest){
				val cActor = EcoreUtil2.getContainerOfType(context, Actor)	
				val spec = EcoreUtil2.getContainerOfType(context, URNspec)
				val allIntElems = EcoreUtil2.getAllContentsOfType(spec, IntentionalElement)
				
				return Scopes.scopeFor(allIntElems, [
					im |
					val esActor = EcoreUtil2.getContainerOfType(im, Actor)
					if (esActor.name === cActor.name) {
						return QualifiedName.create(im.name)
					}
					return QualifiedName.create(esActor.name).append(QualifiedName.create(im.name))
				], IScope.NULLSCOPE)
			}	
		
		
		super.getScope(context, reference)
	}
}
