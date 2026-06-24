#!/usr/bin/env python3
"""
Generate Obsidian canvas file from graphify-out/graph.json
"""
import json
from pathlib import Path
from datetime import datetime

def generate_canvas(graph_json_path, output_path):
    """Convert graph.json to Obsidian canvas format."""
    with open(graph_json_path, 'r') as f:
        data = json.load(f)

    nodes = data['nodes']
    links = data['links']

    # Create canvas structure
    canvas = {
        "nodes": [],
        "edges": []
    }

    # Map node IDs to canvas node IDs
    node_id_map = {}

    # Generate nodes
    for i, node in enumerate(nodes):
        node_id = f"n{i}"
        node_id_map[node['id']] = node_id

        # Calculate position based on community
        community = node.get('community', 0)
        x = (i % 10) * 270
        y = (i // 10) * 110

        # Determine color based on file type
        color = "0"  # default
        if node.get('file_type') == 'code':
            color = "1"  # blue
        elif node.get('file_type') == 'rationale':
            color = "2"  # green

        canvas_node = {
            "id": node_id,
            "type": "text",
            "x": x,
            "y": y,
            "width": 250,
            "height": 100,
            "color": color,
            "text": f"**{node['label']}**\n{node.get('file_type', 'unknown')} | {node.get('source_location', '')}\n{node.get('source_file', '')}"
        }
        canvas['nodes'].append(canvas_node)

    # Generate edges
    for i, link in enumerate(links):
        source_id = link.get('source') or link.get('_src')
        target_id = link.get('target') or link.get('_tgt')

        if source_id in node_id_map and target_id in node_id_map:
            edge = {
                "id": f"e{i}",
                "fromNode": node_id_map[source_id],
                "fromSide": "right",
                "toNode": node_id_map[target_id],
                "toSide": "left",
                "label": link.get('relation', 'unknown')
            }
            canvas['edges'].append(edge)

    # Write canvas file
    with open(output_path, 'w') as f:
        json.dump(canvas, f, indent=2)

    return len(canvas['nodes']), len(canvas['edges'])

if __name__ == '__main__':
    graph_json = Path('/Users/oao/my-brain/graphify-out/graph.json')
    today = datetime.now().strftime('%Y-%m-%d')
    output = Path(f'/Users/oao/my-brain/03-KNOWLEDGE/02-WORKING/knowledge-graph-{today}.canvas')

    nodes, edges = generate_canvas(graph_json, output)
    print(f"Generated canvas: {nodes} nodes, {edges} edges")
    print(f"Output: {output}")
